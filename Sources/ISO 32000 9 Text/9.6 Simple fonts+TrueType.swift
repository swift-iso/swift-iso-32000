public import Byte_Primitives
public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Ownership_Primitives

extension ISO_32000.`9`.`6` {

    public struct Embedded: Sendable {

        public let fontFile: ISO_14496_22.FontFile

        public let data: [Byte]

        public let postScriptName: String

        public let metrics: ISO_32000.`9`.`8`.Metrics

        public let isMonospaced: Bool

        public init(data: [Byte]) throws(ISO_14496_22.FontFile.ParsingError) {
            let fontFile = try ISO_14496_22.FontFile(data: data)

            self.fontFile = fontFile
            self.data = data
            self.postScriptName = fontFile.postScriptName
            self.isMonospaced = fontFile.post.isFixedPitch
            self.metrics = ISO_32000.`9`.`8`.Metrics(fontFile: fontFile)
        }

    }
}

extension ISO_32000.`9`.`6`.Embedded {

    public func descriptor(fontName: ISO_32000.`7`.`3`.COS.Name) -> ISO_32000.`9`.`8`.Descriptor {
        ISO_32000.`9`.`8`.Descriptor(fontFile: fontFile, fontName: fontName)
    }

    public enum SubsettingError: Swift.Error, Sendable {

        case subset(ISO_14496_22.FontSubsetter.SubsetError)

        case parsing(ISO_14496_22.FontFile.ParsingError)
    }

    public func subsetted(for characters: Set<Character>) throws(SubsettingError) -> Self {
        let subsetter = ISO_14496_22.FontSubsetter(fontFile: fontFile)
        let subsetData: [Byte]
        do throws(ISO_14496_22.FontSubsetter.SubsetError) {
            subsetData = try subsetter.subset(characters: characters)
        } catch {
            throw .subset(error)
        }

        do throws(ISO_14496_22.FontFile.ParsingError) {
            return try Self(data: subsetData)
        } catch {
            throw .parsing(error)
        }
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    public init(fontFile: ISO_14496_22.FontFile) {

        var widths: [UInt32: Int] = [:]

        for (codePoint, glyphIndex) in fontFile.cmap.unicodeMapping {
            let advanceWidth = fontFile.hmtx.advanceWidth(for: glyphIndex)
            widths[codePoint] = Int(advanceWidth)
        }

        let ascender = Int(fontFile.hhea.ascender)
        let descender = Int(fontFile.hhea.descender)
        let lineGap = Int(fontFile.hhea.lineGap)

        let capHeight = ascender
        let xHeight = ascender * 2 / 3

        let defaultWidth = Int(fontFile.hmtx.advanceWidth(for: 0))

        let unitsPerEm = Int(fontFile.head.unitsPerEm)

        self.init(
            widths: widths,
            defaultWidth: defaultWidth,
            ascender: ascender,
            descender: descender,
            capHeight: capHeight,
            xHeight: xHeight,
            leading: lineGap,
            unitsPerEm: unitsPerEm
        )
    }
}

extension ISO_32000.`9`.`6` {

    static func sanitizePostScriptName(_ name: String) -> String {
        var result = ""
        result.reserveCapacity(name.count)
        for char in name {
            if char == " " {
                result.append("_")
            } else {
                result.append(char)
            }
        }
        return result
    }
}

extension ISO_32000.`9`.`6`.Font {

    public init(
        embedded: ISO_32000.`9`.`6`.Embedded,
        resourceName: ISO_32000.`7`.`3`.COS.Name,
        weight: Weight = .regular,
        style: Style = .normal
    ) throws(ISO_32000.`7`.`3`.COS.Name.Error) {

        let sanitizedName = ISO_32000.`9`.`6`.sanitizePostScriptName(embedded.postScriptName)

        self.init(
            baseFontName: try ISO_32000.`7`.`3`.COS.Name(sanitizedName),
            resourceName: resourceName,
            metrics: embedded.metrics,
            isMonospaced: embedded.isMonospaced,
            weight: weight,
            style: style,
            family: .custom,
            embeddedSource: embedded
        )
    }

    public enum DataError: Swift.Error, Sendable {

        case parsing(ISO_14496_22.FontFile.ParsingError)

        case name(ISO_32000.`7`.`3`.COS.Name.Error)
    }

    public init(
        data: [Byte],
        resourceName: ISO_32000.`7`.`3`.COS.Name,
        weight: Weight = .regular,
        style: Style = .normal
    ) throws(DataError) {
        let embedded: ISO_32000.`9`.`6`.Embedded
        do throws(ISO_14496_22.FontFile.ParsingError) {
            embedded = try ISO_32000.`9`.`6`.Embedded(data: data)
        } catch {
            throw .parsing(error)
        }
        do throws(ISO_32000.`7`.`3`.COS.Name.Error) {
            try self.init(
                embedded: embedded,
                resourceName: resourceName,
                weight: weight,
                style: style
            )
        } catch {
            throw .name(error)
        }
    }
}
