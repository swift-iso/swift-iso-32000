import Byte
import IEC_61966
import ISO_32000_9_Text
import Ownership
import RFC_3986
import RFC_4648
import Standard_Library_Extensions
public import Witness

extension ISO_32000 {

    public struct Writer: Sendable {

        public var compression: StreamCompression?

        public init(compression: StreamCompression? = nil) {
            self.compression = compression
        }
    }
}

extension ISO_32000.Writer {

    public mutating func write<Buffer: RangeReplaceableCollection>(
        _ document: ISO_32000.Document,
        into buffer: inout Buffer
    ) throws(Error) where Buffer.Element == Byte {
        var state = State(origin: buffer.count)

        writeHeader(document.version, into: &buffer)

        buffer.append(contentsOf: "%\u{E2}\u{E3}\u{CF}\u{D3}\n".utf8.map(Byte.init(bitPattern:)))

        let pageResources = document.pages.map(Self.resources(of:))

        var allFonts: [ISO_32000.COS.Name: ISO_32000.Font] = [:]
        for resources in pageResources {
            for (name, font) in resources.fonts {
                allFonts[name] = font
            }
        }

        var allImages: [ISO_32000.COS.Name: ISO_32000.Image] = [:]
        for resources in pageResources {
            for (name, image) in resources.xObjects {
                allImages[name] = image
            }
        }

        var fontRefs: [ISO_32000.COS.Name: ISO_32000.COS.IndirectReference] = [:]
        for (name, font) in allFonts.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            if let embedded = font.embeddedSource {

                let fontRef = writeEmbeddedTrueTypeFont(
                    font: font,
                    embedded: embedded,
                    state: &state,
                    into: &buffer
                )
                fontRefs[name] = fontRef
            } else {

                let objNum = state.nextObjectNumber()
                fontRefs[name] = ISO_32000.COS.IndirectReference(objectNumber: objNum)

                var fontDict = ISO_32000.COS.Dictionary()
                fontDict[.type] = .name(.font)
                fontDict[.subtype] = .name(.type1)
                fontDict[.baseFont] = .name(font.baseFontName)

                if font.family != .zapfDingbats && font.family != .symbol {
                    fontDict[.encoding] = .name(.winAnsiEncoding)
                }

                state.objectOffsets[objNum] = buffer.count - state.origin
                writeIndirectObject(objNum, object: .dictionary(fontDict), into: &buffer)
            }
        }

        var imageRefs: [ISO_32000.COS.Name: ISO_32000.COS.IndirectReference] = [:]
        for (name, image) in allImages.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            let objNum = state.nextObjectNumber()
            imageRefs[name] = ISO_32000.COS.IndirectReference(objectNumber: objNum)

            var imageDict = ISO_32000.COS.Dictionary()
            imageDict[.type] = .name(.xObject)
            imageDict[.subtype] = .name(.image)
            imageDict[.width] = .integer(Int64(image.pixelWidth))
            imageDict[.height] = .integer(Int64(image.pixelHeight))
            imageDict[.bitsPerComponent] = .integer(Int64(image.bitsPerComponent))

            switch image.colorSpace {
            case .deviceGray:
                imageDict[.colorSpace] = .name(.deviceGray)

            case .deviceRGB:
                imageDict[.colorSpace] = .name(.deviceRGB)

            case .deviceCMYK:
                imageDict[.colorSpace] = .name(.deviceCMYK)
            }

            switch image.filter {
            case .dctDecode:
                imageDict[.filter] = .name(.dctDecode)

            case .flateDecode:
                imageDict[.filter] = .name(.flateDecode)
            }

            if let softMask = image.softMask {
                let maskNum = state.nextObjectNumber()
                imageDict[.sMask] = .reference(ISO_32000.COS.IndirectReference(objectNumber: maskNum))

                var maskDict = ISO_32000.COS.Dictionary()
                maskDict[.type] = .name(.xObject)
                maskDict[.subtype] = .name(.image)
                maskDict[.width] = .integer(Int64(image.pixelWidth))
                maskDict[.height] = .integer(Int64(image.pixelHeight))
                maskDict[.colorSpace] = .name(.deviceGray)
                maskDict[.bitsPerComponent] = .integer(8)
                maskDict[.filter] = .name(.flateDecode)

                let maskStream = ISO_32000.COS.Stream(dictionary: maskDict, data: softMask)
                state.objectOffsets[maskNum] = buffer.count - state.origin
                writeIndirectObject(maskNum, object: .stream(maskStream), into: &buffer)
            }

            let stream = ISO_32000.COS.Stream(dictionary: imageDict, data: image.data)
            state.objectOffsets[objNum] = buffer.count - state.origin
            writeIndirectObject(objNum, object: .stream(stream), into: &buffer)
        }

        var contentRefs: [[ISO_32000.COS.IndirectReference]] = []
        for page in document.pages {
            var pageContentRefs: [ISO_32000.COS.IndirectReference] = []
            for content in page.contents {
                let objNum = state.nextObjectNumber()
                pageContentRefs.append(ISO_32000.COS.IndirectReference(objectNumber: objNum))

                var streamData = content.data
                var streamDict = ISO_32000.COS.Dictionary()

                if let compress = compression {
                    var compressed: [Byte] = []
                    compress.compress(streamData, into: &compressed)
                    if compressed.count < streamData.count {
                        streamData = compressed
                        streamDict[.filter] = .name(.flateDecode)
                    }
                }

                let stream = ISO_32000.COS.Stream(dictionary: streamDict, data: streamData)
                state.objectOffsets[objNum] = buffer.count - state.origin
                writeIndirectObject(objNum, object: .stream(stream), into: &buffer)
            }
            contentRefs.append(pageContentRefs)
        }

        let pagesObjNum = state.nextObjectNumber()
        let pagesRef = ISO_32000.COS.IndirectReference(objectNumber: pagesObjNum)

        var pageRefs: [ISO_32000.COS.IndirectReference] = []
        for _ in document.pages {
            let objNum = state.nextObjectNumber()
            pageRefs.append(ISO_32000.COS.IndirectReference(objectNumber: objNum))
        }

        var annotRefs: [[ISO_32000.COS.IndirectReference]] = []
        for page in document.pages {
            var pageAnnotRefs: [ISO_32000.COS.IndirectReference] = []
            for annotation in page.annotations {
                let objNum = state.nextObjectNumber()
                pageAnnotRefs.append(ISO_32000.COS.IndirectReference(objectNumber: objNum))

                var annotDict = ISO_32000.COS.Dictionary()
                annotDict[.type] = .name(.annot)
                annotDict[.subtype] = .name(annotation.subtype.name)
                annotDict[.rect] = ISO_32000.COS.Object(annotation.rect)

                if let border = annotation.border {
                    annotDict[.border] = .array([
                        .real(border.horizontalRadius),
                        .real(border.verticalRadius),
                        .real(border.width),
                    ])
                }

                switch annotation.content {
                case .link(let link):
                    switch link.target {
                    case .uri(let uri):

                        var actionDict = ISO_32000.COS.Dictionary()
                        actionDict[.s] = .name(.uri)
                        actionDict[.uri] = .string(ISO_32000.COS.StringValue(uri.value))
                        annotDict[.a] = .dictionary(actionDict)

                    case .destination(let dest):

                        annotDict[.dest] = try serializeDestination(dest, pageRefs: pageRefs)
                    }

                default:

                    break
                }

                state.objectOffsets[objNum] = buffer.count - state.origin
                writeIndirectObject(objNum, object: .dictionary(annotDict), into: &buffer)
            }
            annotRefs.append(pageAnnotRefs)
        }

        for (i, page) in document.pages.enumerated() {
            let pageRef = pageRefs[i]

            var pageDict = ISO_32000.COS.Dictionary()
            pageDict[.type] = .name(.page)
            pageDict[.parent] = .reference(pagesRef)
            pageDict[.mediaBox] = ISO_32000.COS.Object(page.mediaBox)

            if let cropBox = page.cropBox {
                pageDict[.cropBox] = ISO_32000.COS.Object(cropBox)
            }

            if let bleedBox = page.bleedBox {
                pageDict[.bleedBox] = ISO_32000.COS.Object(bleedBox)
            }

            if let trimBox = page.trimBox {
                pageDict[.trimBox] = ISO_32000.COS.Object(trimBox)
            }

            if let artBox = page.artBox {
                pageDict[.artBox] = ISO_32000.COS.Object(artBox)
            }

            if let rotation = page.rotation, rotation.underlying != 0 {
                pageDict[.rotate] = .integer(Int64(rotation.underlying))
            }

            if contentRefs[i].count == 1 {
                pageDict[.contents] = .reference(contentRefs[i][0])
            } else if contentRefs[i].count > 1 {
                pageDict[.contents] = .array(contentRefs[i].map { .reference($0) })
            }

            if !annotRefs[i].isEmpty {
                pageDict[.annots] = .array(annotRefs[i].map { .reference($0) })
            }

            let resources = pageResources[i]
            var resourcesDict = ISO_32000.COS.Dictionary()

            if !resources.fonts.isEmpty {
                var fontResourceDict = ISO_32000.COS.Dictionary()
                for name in resources.fonts.keys
                    .sorted(by: { $0.rawValue < $1.rawValue })
                {
                    if let ref = fontRefs[name] {
                        fontResourceDict[name] = .reference(ref)
                    }
                }
                resourcesDict[.font] = .dictionary(fontResourceDict)
            }

            if !resources.xObjects.isEmpty {
                var xObjectDict = ISO_32000.COS.Dictionary()
                for name in resources.xObjects.keys
                    .sorted(by: { $0.rawValue < $1.rawValue })
                {
                    if let ref = imageRefs[name] {
                        xObjectDict[name] = .reference(ref)
                    }
                }
                resourcesDict[.xObject] = .dictionary(xObjectDict)
            }

            var procSetArray: [ISO_32000.COS.Object] = [.name(.pdf), .name(.text)]
            if !resources.xObjects.isEmpty {
                procSetArray.append(ISO_32000.COS.Object.name(.imagec))
                procSetArray.append(ISO_32000.COS.Object.name(.imageb))
            }
            resourcesDict[.procSet] = .array(procSetArray)

            pageDict[.resources] = .dictionary(resourcesDict)

            state.objectOffsets[pageRef.objectNumber] = buffer.count - state.origin
            writeIndirectObject(
                pageRef.objectNumber,
                object: .dictionary(pageDict),
                into: &buffer
            )
        }

        var pagesDict = ISO_32000.COS.Dictionary()
        pagesDict[.type] = .name(.pages)
        pagesDict[.kids] = .array(pageRefs.map { .reference($0) })
        pagesDict[.count] = .integer(Int64(document.pages.count))

        state.objectOffsets[pagesObjNum] = buffer.count - state.origin
        writeIndirectObject(pagesObjNum, object: .dictionary(pagesDict), into: &buffer)

        var outlineRef: ISO_32000.COS.IndirectReference?
        if let outline = document.outline, !outline.isEmpty {
            outlineRef = try writeOutline(outline, pageRefs: pageRefs, state: &state, into: &buffer)
        }

        let catalogObjNum = state.nextObjectNumber()
        var catalogDict = ISO_32000.COS.Dictionary()
        catalogDict[.type] = .name(.catalog)
        catalogDict[.pages] = .reference(pagesRef)

        if let outlineRef {
            catalogDict[.outlines] = .reference(outlineRef)
        }

        if let viewer = document.viewer, viewer != .default {
            catalogDict[.viewerPreferences] = .dictionary(viewerPreferences(viewer))
        }

        state.objectOffsets[catalogObjNum] = buffer.count - state.origin
        writeIndirectObject(catalogObjNum, object: .dictionary(catalogDict), into: &buffer)

        var infoRef: ISO_32000.COS.IndirectReference?
        if let info = document.info {
            let infoObjNum = state.nextObjectNumber()
            infoRef = ISO_32000.COS.IndirectReference(objectNumber: infoObjNum)

            var infoDict = ISO_32000.COS.Dictionary()
            if let title = info.title {
                infoDict[.title] = .string(ISO_32000.COS.StringValue(title))
            }
            if let author = info.author {
                infoDict[.author] = .string(ISO_32000.COS.StringValue(author))
            }
            if let subject = info.subject {
                infoDict[.subject] = .string(ISO_32000.COS.StringValue(subject))
            }
            if let keywords = info.keywords {
                infoDict[.keywords] = .string(ISO_32000.COS.StringValue(keywords))
            }
            if let creator = info.creator {
                infoDict[.creator] = .string(ISO_32000.COS.StringValue(creator))
            }
            if let producer = info.producer {
                infoDict[.producer] = .string(ISO_32000.COS.StringValue(producer))
            }
            if let date = info.creationDate {
                infoDict[.creationDate] = .string(ISO_32000.COS.StringValue(date.description))
            }
            if let date = info.modificationDate {
                infoDict[.modDate] = .string(ISO_32000.COS.StringValue(date.description))
            }

            state.objectOffsets[infoObjNum] = buffer.count - state.origin
            writeIndirectObject(infoObjNum, object: .dictionary(infoDict), into: &buffer)
        }

        let xrefOffset = buffer.count - state.origin
        writeXref(state: state, into: &buffer)

        writeTrailer(
            size: state.objectCount + 1,
            rootRef: ISO_32000.COS.IndirectReference(objectNumber: catalogObjNum),
            infoRef: infoRef,
            xrefOffset: xrefOffset,
            into: &buffer
        )
    }

    public mutating func write(_ document: ISO_32000.Document) throws(Error) -> [Byte] {
        var buffer: [Byte] = []
        try write(document, into: &buffer)
        return buffer
    }

    private func writeHeader<Buffer: RangeReplaceableCollection>(
        _ version: ISO_32000.Version,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: "\(version.header)\n".utf8.map(Byte.init(bitPattern:)))
    }

    private func writeIndirectObject<Buffer: RangeReplaceableCollection>(
        _ objectNumber: Int,
        object: ISO_32000.COS.Object,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: "\(objectNumber) 0 obj\n".utf8.map(Byte.init(bitPattern:)))
        ISO_32000.COS.serialize(object, into: &buffer)
        buffer.append(contentsOf: "\nendobj\n".utf8.map(Byte.init(bitPattern:)))
    }

    private func writeXref<Buffer: RangeReplaceableCollection>(
        state: State,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: "xref\n".utf8.map(Byte.init(bitPattern:)))
        buffer.append(contentsOf: "0 \(state.objectCount + 1)\n".utf8.map(Byte.init(bitPattern:)))

        buffer.append(contentsOf: "0000000000 65535 f \n".utf8.map(Byte.init(bitPattern:)))

        (1...state.objectCount).forEach { i in
            let offset = state.objectOffsets[i] ?? 0
            var offsetStr = Swift::String(offset)
            while offsetStr.count < 10 {
                offsetStr = "0" + offsetStr
            }
            let entry = "\(offsetStr) 00000 n \n"
            buffer.append(contentsOf: entry.utf8.map(Byte.init(bitPattern:)))
        }
    }

    private struct OutlineFlatItem {
        let item: ISO_32000.Outline.Item
        let objNum: Int
        let parentObjNum: Int
        let prevObjNum: Int?
        let nextObjNum: Int?
        let firstChildObjNum: Int?
        let lastChildObjNum: Int?
    }

    private func writeOutline<Buffer: RangeReplaceableCollection>(
        _ outline: ISO_32000.Outline.Root,
        pageRefs: [ISO_32000.COS.IndirectReference],
        state: inout State,
        into buffer: inout Buffer
    ) throws(Error) -> ISO_32000.COS.IndirectReference where Buffer.Element == Byte {

        let outlineObjNum = state.nextObjectNumber()
        let outlineRef = ISO_32000.COS.IndirectReference(objectNumber: outlineObjNum)

        var itemObjNums: [Int] = []
        var allItems: [ISO_32000.Outline.Item] = []

        func assignObjectNumbers(_ items: [ISO_32000.Outline.Item]) {
            for item in items {
                let objNum = state.nextObjectNumber()
                itemObjNums.append(objNum)
                allItems.append(item)
                if !item.children.isEmpty {
                    assignObjectNumbers(item.children)
                }
            }
        }
        assignObjectNumbers(outline.items)

        var flatItems: [OutlineFlatItem] = []
        var currentIndex = 0

        func buildFlatList(_ items: [ISO_32000.Outline.Item], parentObjNum: Int) {

            var siblingObjNums: [Int] = []
            var tempIndex = currentIndex
            for item in items {
                siblingObjNums.append(itemObjNums[tempIndex])
                tempIndex += 1
                tempIndex += countDescendants(item)
            }

            for (i, item) in items.enumerated() {
                let myObjNum = itemObjNums[currentIndex]
                currentIndex += 1

                let prevObjNum = i > 0 ? siblingObjNums[i - 1] : nil
                let nextObjNum = i < items.count - 1 ? siblingObjNums[i + 1] : nil

                var firstChildObjNum: Int? = nil
                var lastChildObjNum: Int? = nil
                if !item.children.isEmpty {
                    firstChildObjNum = itemObjNums[currentIndex]

                    var lastChildIndex = currentIndex
                    for (j, child) in item.children.enumerated() {
                        if j == item.children.count - 1 {
                            lastChildObjNum = itemObjNums[lastChildIndex]
                        }
                        lastChildIndex += 1
                        lastChildIndex += countDescendants(child)
                    }
                }

                flatItems.append(
                    OutlineFlatItem(
                        item: item,
                        objNum: myObjNum,
                        parentObjNum: parentObjNum,
                        prevObjNum: prevObjNum,
                        nextObjNum: nextObjNum,
                        firstChildObjNum: firstChildObjNum,
                        lastChildObjNum: lastChildObjNum
                    )
                )

                if !item.children.isEmpty {
                    buildFlatList(item.children, parentObjNum: myObjNum)
                }
            }
        }

        func countDescendants(_ item: ISO_32000.Outline.Item) -> Int {
            var count = 0
            for child in item.children {
                count += 1
                count += countDescendants(child)
            }
            return count
        }

        buildFlatList(outline.items, parentObjNum: outlineObjNum)

        var outlineDict = ISO_32000.COS.Dictionary()
        outlineDict[.type] = .name(.outlines)

        if !outline.items.isEmpty {
            outlineDict[.first] = .reference(
                ISO_32000.COS.IndirectReference(objectNumber: itemObjNums[0])
            )

            var lastTopLevelIndex = 0
            for (i, item) in outline.items.enumerated() {
                if i == outline.items.count - 1 {
                    break
                }
                lastTopLevelIndex += 1
                lastTopLevelIndex += countDescendants(item)
            }
            outlineDict[.last] = .reference(
                ISO_32000.COS.IndirectReference(objectNumber: itemObjNums[lastTopLevelIndex])
            )
        }

        outlineDict[.count] = .integer(Int64(outline.count))

        state.objectOffsets[outlineObjNum] = buffer.count - state.origin
        writeIndirectObject(outlineObjNum, object: .dictionary(outlineDict), into: &buffer)

        for fi in flatItems {
            var itemDict = ISO_32000.COS.Dictionary()
            itemDict[.title] = .string(ISO_32000.COS.StringValue(fi.item.title))
            itemDict[.parent] = .reference(
                ISO_32000.COS.IndirectReference(objectNumber: fi.parentObjNum)
            )

            if let prev = fi.prevObjNum {
                itemDict[.prev] = .reference(ISO_32000.COS.IndirectReference(objectNumber: prev))
            }
            if let next = fi.nextObjNum {
                itemDict[.next] = .reference(ISO_32000.COS.IndirectReference(objectNumber: next))
            }
            if let first = fi.firstChildObjNum {
                itemDict[.first] = .reference(ISO_32000.COS.IndirectReference(objectNumber: first))
            }
            if let last = fi.lastChildObjNum {
                itemDict[.last] = .reference(ISO_32000.COS.IndirectReference(objectNumber: last))
            }

            if !fi.item.children.isEmpty {
                let descendantCount = fi.item.children.reduce(0) { $0 + $1.visibleDescendantCount }
                let countValue = fi.item.isOpen ? descendantCount : -descendantCount
                itemDict[.count] = .integer(Int64(countValue))
            }

            if let target = fi.item.target {
                switch target {
                case .destination(let destination):
                    itemDict[.dest] = try serializeDestination(destination, pageRefs: pageRefs)

                case .uri(let action):
                    var actionDict = ISO_32000.COS.Dictionary()
                    actionDict[.s] = .name(.uri)
                    actionDict[.uri] = .string(ISO_32000.COS.StringValue(action.uri.value))
                    if action.isMap {
                        actionDict[.isMap] = .boolean(true)
                    }
                    itemDict[.a] = .dictionary(actionDict)

                case .named(let action):
                    var actionDict = ISO_32000.COS.Dictionary()
                    actionDict[.s] = .name(.named)
                    actionDict[.n] = .name(Self.name(action.name.rawValue))
                    itemDict[.a] = .dictionary(actionDict)

                case .javaScript(let action):
                    var actionDict = ISO_32000.COS.Dictionary()
                    actionDict[.s] = .name(.javaScript)
                    actionDict[.js] = .string(ISO_32000.COS.StringValue(action.script))
                    itemDict[.a] = .dictionary(actionDict)
                }
            }

            if let color = fi.item.color {
                itemDict[.c] = .array([.real(color.r), .real(color.g), .real(color.b)])
            }

            if !fi.item.flags.isEmpty {
                itemDict[.f] = .integer(Int64(fi.item.flags.rawValue))
            }

            state.objectOffsets[fi.objNum] = buffer.count - state.origin
            writeIndirectObject(fi.objNum, object: .dictionary(itemDict), into: &buffer)
        }

        return outlineRef
    }

    private static func resources(of page: ISO_32000.Page) -> ISO_32000.Resources {
        var resources = page.resources
        for content in page.contents {
            for font in content.fontsUsed where resources.fonts[font.resourceName] == nil {
                resources.addFont(font)
            }
            for image in content.imagesUsed where resources.xObjects[image.resourceName] == nil {
                resources.addImage(image)
            }
        }
        return resources
    }

    private func viewerPreferences(_ viewer: ISO_32000.Viewer) -> ISO_32000.COS.Dictionary {
        let defaults = ISO_32000.Viewer.default
        var dict = ISO_32000.COS.Dictionary()
        let flags: [(ISO_32000.COS.Name, Bool, Bool)] = [
            (.hideToolbar, viewer.hideToolbar, defaults.hideToolbar),
            (.hideMenubar, viewer.hideMenubar, defaults.hideMenubar),
            (.hideWindowUI, viewer.hideWindowUI, defaults.hideWindowUI),
            (.fitWindow, viewer.fitWindow, defaults.fitWindow),
            (.centerWindow, viewer.centerWindow, defaults.centerWindow),
            (.displayDocTitle, viewer.displayDocTitle, defaults.displayDocTitle),
        ]
        for (key, value, fallback) in flags where value != fallback {
            dict[key] = .boolean(value)
        }
        let names: [(ISO_32000.COS.Name, String, String)] = [
            (.nonFullScreenPageMode, viewer.nonFullScreenPageMode.rawValue, defaults.nonFullScreenPageMode.rawValue),
            (.direction, viewer.direction.rawValue, defaults.direction.rawValue),
            (.viewArea, viewer.view.area.rawValue, defaults.view.area.rawValue),
            (.viewClip, viewer.view.clip.rawValue, defaults.view.clip.rawValue),
            (.printArea, viewer.print.area.rawValue, defaults.print.area.rawValue),
            (.printClip, viewer.print.clip.rawValue, defaults.print.clip.rawValue),
            (.printScaling, viewer.print.scaling.rawValue, defaults.print.scaling.rawValue),
        ]
        for (key, value, fallback) in names where value != fallback {
            dict[key] = .name(Self.name(value))
        }
        if let duplex = viewer.print.duplex {
            dict[.duplex] = .name(Self.name(duplex.rawValue))
        }
        if let pickTray = viewer.print.pickTrayByPDFSize {
            dict[.pickTrayByPDFSize] = .boolean(pickTray)
        }
        if let ranges = viewer.print.pageRange, !ranges.isEmpty {
            dict[.printPageRange] = .array(
                ranges.flatMap { [.integer(Int64($0.first)), .integer(Int64($0.last))] }
            )
        }
        if let copies = viewer.print.numCopies {
            dict[.numCopies] = .integer(Int64(copies))
        }
        if !viewer.enforce.isEmpty {
            dict[.enforce] = .array(viewer.enforce.map { .name(Self.name($0.rawValue)) })
        }
        return dict
    }

    private static func reference(
        toPage index: Int,
        in pageRefs: [ISO_32000.COS.IndirectReference]
    ) throws(Error) -> ISO_32000.COS.IndirectReference {
        guard pageRefs.indices.contains(index) else {
            throw .pageOutOfRange(index: index, pageCount: pageRefs.count)
        }
        return pageRefs[index]
    }

    private static func name(_ rawValue: String) -> ISO_32000.COS.Name {
        do {
            return try ISO_32000.COS.Name(rawValue)
        } catch {
            preconditionFailure("A viewer preference or named action raw value is a valid PDF name: \(error)")
        }
    }

    private func serializeDestination(
        _ dest: ISO_32000.Destination,
        pageRefs: [ISO_32000.COS.IndirectReference]
    ) throws(Error) -> ISO_32000.COS.Object {
        switch dest {
        case .xyz(let page, let left, let top, let zoom):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.xyz),
                left.map { .real($0.underlying) } ?? .null,
                top.map { .real($0.underlying) } ?? .null,
                zoom.map { .real($0) } ?? .null,
            ])

        case .fit(let page):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([.reference(pageRef), .name(.fit)])

        case .fitH(let page, let top):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.fitH),
                top.map { .real($0.underlying) } ?? .null,
            ])

        case .fitV(let page, let left):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.fitV),
                left.map { .real($0.underlying) } ?? .null,
            ])

        case .fitR(let page, let left, let bottom, let right, let top):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.fitR),
                .real(left.underlying),
                .real(bottom.underlying),
                .real(right.underlying),
                .real(top.underlying),
            ])

        case .fitB(let page):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([.reference(pageRef), .name(.fitB)])

        case .fitBH(let page, let top):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.fitBH),
                top.map { .real($0.underlying) } ?? .null,
            ])

        case .fitBV(let page, let left):
            let pageRef = try Self.reference(toPage: page, in: pageRefs)
            return .array([
                .reference(pageRef),
                .name(.fitBV),
                left.map { .real($0.underlying) } ?? .null,
            ])

        case .named(let name):
            return .string(ISO_32000.COS.StringValue(name))
        }
    }

    private func writeTrailer<Buffer: RangeReplaceableCollection>(
        size: Int,
        rootRef: ISO_32000.COS.IndirectReference,
        infoRef: ISO_32000.COS.IndirectReference?,
        xrefOffset: Int,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: "trailer\n".utf8.map(Byte.init(bitPattern:)))

        var trailerDict = ISO_32000.COS.Dictionary()
        trailerDict[.size] = .integer(Int64(size))
        trailerDict[.root] = .reference(rootRef)

        if let info = infoRef {
            trailerDict[.info] = .reference(info)
        }

        ISO_32000.COS.Dictionary.serialize(trailerDict, into: &buffer)

        buffer.append(contentsOf: "\nstartxref\n".utf8.map(Byte.init(bitPattern:)))
        buffer.append(contentsOf: "\(xrefOffset)\n".utf8.map(Byte.init(bitPattern:)))
        buffer.append(contentsOf: "%%EOF\n".utf8.map(Byte.init(bitPattern:)))
    }

    private mutating func writeEmbeddedTrueTypeFont<Buffer: RangeReplaceableCollection>(
        font: ISO_32000.Font,
        embedded: ISO_32000.`9`.`6`.Embedded,
        state: inout State,
        into buffer: inout Buffer
    ) -> ISO_32000.COS.IndirectReference where Buffer.Element == Byte {

        let fontFileObjNum = state.nextObjectNumber()
        let fontFileRef = ISO_32000.COS.IndirectReference(objectNumber: fontFileObjNum)

        var fontFileData = embedded.data
        var fontFileDict = ISO_32000.COS.Dictionary()
        fontFileDict[.length1] = .integer(Int64(embedded.data.count))

        if let compress = compression {
            var compressed: [Byte] = []
            compress.compress(fontFileData, into: &compressed)
            if compressed.count < fontFileData.count {
                fontFileData = compressed
                fontFileDict[.filter] = .name(.flateDecode)
            }
        }

        let fontFileStream = ISO_32000.COS.Stream(dictionary: fontFileDict, data: fontFileData)
        state.objectOffsets[fontFileObjNum] = buffer.count - state.origin
        writeIndirectObject(fontFileObjNum, object: .stream(fontFileStream), into: &buffer)

        let descriptorObjNum = state.nextObjectNumber()
        let descriptorRef = ISO_32000.COS.IndirectReference(objectNumber: descriptorObjNum)

        let descriptor = embedded.descriptor(fontName: font.baseFontName)
        var descriptorDict = ISO_32000.COS.Dictionary()
        descriptorDict[.type] = .name(.fontDescriptor)
        descriptorDict[.fontName] = .name(font.baseFontName)
        descriptorDict[.fontFlags] = .integer(Int64(descriptor.flags.rawValue))
        descriptorDict[.fontBBox] = .array([
            .integer(Int64(descriptor.fontBBox.llx)),
            .integer(Int64(descriptor.fontBBox.lly)),
            .integer(Int64(descriptor.fontBBox.urx)),
            .integer(Int64(descriptor.fontBBox.ury)),
        ])
        descriptorDict[.italicAngle] = .real(descriptor.italicAngle)
        descriptorDict[.ascent] = .integer(Int64(descriptor.ascent.underlying))
        descriptorDict[.descent] = .integer(Int64(descriptor.descent.underlying))
        descriptorDict[.capHeight] = .integer(Int64(descriptor.capHeight.underlying))
        descriptorDict[.stemV] = .integer(Int64(descriptor.stemV.underlying))
        descriptorDict[.fontFile2] = .reference(fontFileRef)

        state.objectOffsets[descriptorObjNum] = buffer.count - state.origin
        writeIndirectObject(
            descriptorObjNum,
            object: .dictionary(descriptorDict),
            into: &buffer
        )

        let toUnicodeObjNum = state.nextObjectNumber()
        let toUnicodeRef = ISO_32000.COS.IndirectReference(objectNumber: toUnicodeObjNum)

        var toUnicodeData = generateToUnicodeCMap()
        var toUnicodeDict = ISO_32000.COS.Dictionary()

        if let compress = compression {
            var compressed: [Byte] = []
            compress.compress(toUnicodeData, into: &compressed)
            if compressed.count < toUnicodeData.count {
                toUnicodeData = compressed
                toUnicodeDict[.filter] = .name(.flateDecode)
            }
        }

        let toUnicodeStream = ISO_32000.COS.Stream(dictionary: toUnicodeDict, data: toUnicodeData)
        state.objectOffsets[toUnicodeObjNum] = buffer.count - state.origin
        writeIndirectObject(toUnicodeObjNum, object: .stream(toUnicodeStream), into: &buffer)

        let fontObjNum = state.nextObjectNumber()
        let fontRef = ISO_32000.COS.IndirectReference(objectNumber: fontObjNum)

        var fontDict = ISO_32000.COS.Dictionary()
        fontDict[.type] = .name(.font)
        fontDict[.subtype] = .name(.trueType)
        fontDict[.baseFont] = .name(font.baseFontName)
        fontDict[.fontDescriptor] = .reference(descriptorRef)
        fontDict[.encoding] = .name(.winAnsiEncoding)
        fontDict[.toUnicode] = .reference(toUnicodeRef)

        let firstChar = 32
        let lastChar = 255
        fontDict[.firstChar] = .integer(Int64(firstChar))
        fontDict[.lastChar] = .integer(Int64(lastChar))

        var widthsArray: [ISO_32000.COS.Object] = []
        let unitsPerEm = embedded.metrics.unitsPerEm
        (firstChar...lastChar).forEach { charCode in
            let codePoint =
                ISO_32000.WinAnsiEncoding.decode(Byte(UInt8(charCode)))?.value ?? UInt32(charCode)
            let width = embedded.metrics.width(forCodePoint: codePoint)

            let scaledWidth = (width * 1000) / unitsPerEm
            widthsArray.append(.integer(Int64(scaledWidth)))
        }
        fontDict[.widths] = .array(widthsArray)

        state.objectOffsets[fontObjNum] = buffer.count - state.origin
        writeIndirectObject(fontObjNum, object: .dictionary(fontDict), into: &buffer)

        return fontRef
    }

    private func generateToUnicodeCMap() -> [Byte] {
        var cmap = ""

        cmap += "/CIDInit /ProcSet findresource begin\n"
        cmap += "12 dict begin\n"
        cmap += "begincmap\n"
        cmap += "/CIDSystemInfo << /Registry (Adobe) /Ordering (UCS) /Supplement 0 >> def\n"
        cmap += "/CMapName /Adobe-Identity-UCS def\n"
        cmap += "/CMapType 2 def\n"

        cmap += "1 begincodespacerange\n"
        cmap += "<00> <FF>\n"
        cmap += "endcodespacerange\n"

        let mappings = Self.winAnsiToUnicode.sorted(by: { $0.key < $1.key })

        for groupStart in stride(from: 0, to: mappings.count, by: Self.maxEntriesPerBFCharGroup) {
            let group = mappings[groupStart..<min(groupStart + Self.maxEntriesPerBFCharGroup, mappings.count)]
            cmap += "\(group.count) beginbfchar\n"
            for (charCode, unicodeValue) in group {

                var charCodeHex: [ASCII.Code] = []
                RFC_4648.Base16.encode(UInt8(charCode), into: &charCodeHex, uppercase: true)
                var unicodeHex: [ASCII.Code] = []
                RFC_4648.Base16.encode(UInt16(unicodeValue), into: &unicodeHex, uppercase: true)
                cmap +=
                    "<\(String(decoding: charCodeHex.map(\.underlying), as: UTF8.self))> <\(String(decoding: unicodeHex.map(\.underlying), as: UTF8.self))>\n"
            }
            cmap += "endbfchar\n"
        }

        cmap += "endcmap\n"
        cmap += "CMapName currentdict /CMap defineresource pop\n"
        cmap += "end\n"
        cmap += "end\n"

        return cmap.utf8.map(Byte.init(bitPattern:))
    }

    private static let maxEntriesPerBFCharGroup = 100

    private static let winAnsiToUnicode: [Int: Int] = {
        var mapping: [Int: Int] = [:]

        (32...127).forEach { code in
            mapping[code] = code
        }
        (160...255).forEach { code in
            mapping[code] = code
        }

        mapping[128] = 0x20AC

        mapping[130] = 0x201A
        mapping[131] = 0x0192
        mapping[132] = 0x201E
        mapping[133] = 0x2026
        mapping[134] = 0x2020
        mapping[135] = 0x2021
        mapping[136] = 0x02C6
        mapping[137] = 0x2030
        mapping[138] = 0x0160
        mapping[139] = 0x2039
        mapping[140] = 0x0152

        mapping[142] = 0x017D

        mapping[145] = 0x2018
        mapping[146] = 0x2019
        mapping[147] = 0x201C
        mapping[148] = 0x201D
        mapping[149] = 0x2022
        mapping[150] = 0x2013
        mapping[151] = 0x2014
        mapping[152] = 0x02DC
        mapping[153] = 0x2122
        mapping[154] = 0x0161
        mapping[155] = 0x203A
        mapping[156] = 0x0153

        mapping[158] = 0x017E
        mapping[159] = 0x0178

        return mapping
    }()
}

extension ISO_32000.Writer {

    public enum Error: Swift::Error, Sendable, Hashable {

        case pageOutOfRange(index: Int, pageCount: Int)
    }
}

extension ISO_32000.Writer {

    struct State {
        let origin: Int
        var objectCount: Int = 0
        var objectOffsets: [Int: Int] = [:]
    }
}

extension ISO_32000.Writer.State {
    mutating func nextObjectNumber() -> Int {
        objectCount += 1
        return objectCount
    }
}

extension ISO_32000 {

    public struct StreamCompression: Sendable, Witness.`Protocol` {
        private let _compress: @Sendable ([Byte], inout [Byte]) -> Void

        public init(compress: @escaping @Sendable ([Byte], inout [Byte]) -> Void) {
            self._compress = compress
        }
    }
}

extension ISO_32000.StreamCompression {

    public func compress(_ input: [Byte], into output: inout [Byte]) {
        _compress(input, &output)
    }
}
