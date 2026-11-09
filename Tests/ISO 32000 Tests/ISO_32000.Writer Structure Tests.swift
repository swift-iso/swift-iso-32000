import Foundation
import IEC_61966
import RFC_3986
import Testing

@testable import ISO_32000
@testable import ISO_32000_9_Text

@Suite
struct `ISO_32000.Writer Structure Tests` {

    static func text(_ document: ISO_32000.Document) throws -> String {
        var writer = ISO_32000.Writer()
        return try String(decoding: writer.write(document), as: UTF8.self)
    }

    static let onePage = [ISO_32000.Page.empty(size: .letter)]

    @Test
    func `writing after existing bytes keeps offsets relative to the document`() throws {
        let document = ISO_32000.Document(
            info: ISO_32000.Document.Info(title: "Offsets"),
            pages: Self.onePage
        )
        var writer = ISO_32000.Writer()
        let fresh = try writer.write(document)

        let prefix = Array("leading bytes that are not part of the PDF\n".utf8).map(Byte.init(bitPattern:))
        var buffer = prefix
        try writer.write(document, into: &buffer)

        #expect(Array(buffer.dropFirst(prefix.count)) == fresh)

        let str = String(decoding: fresh, as: UTF8.self)
        let lines = str.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        let startxref = try #require(lines.firstIndex(of: "startxref"))
        let xrefOffset = try #require(Int(lines[startxref + 1]))
        #expect(fresh[xrefOffset...].starts(with: Array("xref\n".utf8).map(Byte.init(bitPattern:))))

        let xrefLine = try #require(lines.firstIndex(of: "xref"))
        let header = lines[xrefLine + 1].split(separator: " ")
        let count = try #require(Int(header[1]))
        for objectNumber in 1..<count {
            let offset = try #require(Int(lines[xrefLine + 2 + objectNumber].prefix(10)))
            let expected = Array("\(objectNumber) 0 obj\n".utf8).map(Byte.init(bitPattern:))
            #expect(fresh[offset...].starts(with: expected), "object \(objectNumber) at \(offset)")
        }
    }

    @Test
    func `an outline destination past the last page is reported`() throws {
        let document = ISO_32000.Document(
            pages: Self.onePage,
            outline: ISO_32000.Outline.Root(items: [
                ISO_32000.Outline.Item(title: "Missing", destination: .fit(page: 3))
            ])
        )
        #expect(throws: ISO_32000.Writer.Error.pageOutOfRange(index: 3, pageCount: 1)) {
            try Self.text(document)
        }
    }

    @Test
    func `a destination in a document without pages is reported, not trapped`() throws {
        let document = ISO_32000.Document(
            pages: [],
            outline: ISO_32000.Outline.Root(items: [
                ISO_32000.Outline.Item(title: "Nowhere", destination: .fit(page: 0))
            ])
        )
        #expect(throws: ISO_32000.Writer.Error.pageOutOfRange(index: 0, pageCount: 0)) {
            try Self.text(document)
        }
    }

    @Test
    func `a link annotation destination past the last page is reported`() throws {
        let link = ISO_32000.Annotation(
            rect: .letter,
            content: .link(ISO_32000.Annotation.Link(destination: .xyz(page: -1, left: nil, top: nil, zoom: nil)))
        )
        let document = ISO_32000.Document(pages: [ISO_32000.Page(mediaBox: .letter, annotations: [link])])
        #expect(throws: ISO_32000.Writer.Error.pageOutOfRange(index: -1, pageCount: 1)) {
            try Self.text(document)
        }
    }

    @Test
    func `a closed outline item counts its would-be-visible descendants negatively`() throws {
        let closed = ISO_32000.Outline.Item(
            title: "Closed",
            destination: .fit(page: 0),
            children: [
                ISO_32000.Outline.Item(
                    title: "A",
                    destination: .fit(page: 0),
                    children: [ISO_32000.Outline.Item(title: "A1", destination: .fit(page: 0))]
                ),
                ISO_32000.Outline.Item(title: "B", destination: .fit(page: 0)),
            ],
            isOpen: false
        )
        let str = try Self.text(
            ISO_32000.Document(pages: Self.onePage, outline: ISO_32000.Outline.Root(items: [closed]))
        )
        #expect(str.contains("/Count -3"))
        #expect(str.contains("/Count 1"))
        #expect(!str.contains("/Count 0"))
    }

    @Test
    func `an open outline item counts its visible descendants`() throws {
        let open = ISO_32000.Outline.Item(
            title: "Open",
            destination: .fit(page: 0),
            children: [
                ISO_32000.Outline.Item(title: "A", destination: .fit(page: 0)),
                ISO_32000.Outline.Item(title: "B", destination: .fit(page: 0)),
            ]
        )
        let str = try Self.text(
            ISO_32000.Document(pages: Self.onePage, outline: ISO_32000.Outline.Root(items: [open]))
        )
        #expect(str.contains("/Count 2"))
        #expect(str.contains("/Count 3"))
    }

    @Test
    func `outline action targets, colour and flags are written`() throws {
        let items = [
            ISO_32000.Outline.Item(
                title: "Site",
                target: .uri(ISO_32000.Action.URI(uri: try RFC_3986.URI("https://example.com"))),
                color: ISO_32000.DeviceRGB(r: 1, g: 0, b: 0),
                flags: .bold
            ),
            ISO_32000.Outline.Item(
                title: "Next",
                target: .named(ISO_32000.Action.Named(name: .nextPage))
            ),
            ISO_32000.Outline.Item(
                title: "Script",
                target: .javaScript(ISO_32000.Action.JavaScript(script: "app.alert(1)"))
            ),
        ]
        let str = try Self.text(
            ISO_32000.Document(pages: Self.onePage, outline: ISO_32000.Outline.Root(items: items))
        )
        #expect(str.contains("/S /URI"))
        #expect(str.contains("example.com"))
        #expect(str.contains("/S /Named"))
        #expect(str.contains("/N /NextPage"))
        #expect(str.contains("/S /JavaScript"))
        #expect(str.contains("/JS"))
        #expect(str.contains("/C [1 0 0]"))
        #expect(str.contains("/F 2"))
    }

    @Test
    func `bleed, trim and art boxes are written`() throws {
        let page = ISO_32000.Page(
            mediaBox: .letter,
            bleedBox: .letter,
            trimBox: .letter,
            artBox: .letter
        )
        let str = try Self.text(ISO_32000.Document(pages: [page]))
        #expect(str.contains("/BleedBox"))
        #expect(str.contains("/TrimBox"))
        #expect(str.contains("/ArtBox"))
    }

    @Test
    func `viewer preferences that differ from the defaults are written`() throws {
        let viewer = ISO_32000.Viewer(
            hideToolbar: true,
            displayDocTitle: true,
            direction: .rightToLeft,
            print: ISO_32000.Viewer.Print(scaling: .none, numCopies: 2)
        )
        let str = try Self.text(ISO_32000.Document(pages: Self.onePage, viewer: viewer))
        #expect(str.contains("/ViewerPreferences"))
        #expect(str.contains("/HideToolbar true"))
        #expect(str.contains("/DisplayDocTitle true"))
        #expect(str.contains("/Direction /R2L"))
        #expect(str.contains("/PrintScaling /None"))
        #expect(str.contains("/NumCopies 2"))
        #expect(!str.contains("/HideMenubar"))
    }

    @Test
    func `default viewer preferences add nothing`() throws {
        let str = try Self.text(ISO_32000.Document(pages: Self.onePage, viewer: .default))
        #expect(!str.contains("/ViewerPreferences"))
    }

    @Test
    func `a font set in the content stream but absent from the resources is still written`() throws {
        let page = ISO_32000.Page(
            mediaBox: .letter,
            content: ISO_32000.ContentStream { builder in
                builder.beginText()
                builder.setFont(ISO_32000.Font.courier, size: 12)
                builder.showText("Courier")
                builder.endText()
            }
        )
        let str = try Self.text(ISO_32000.Document(pages: [page]))
        #expect(str.contains("/BaseFont /Courier"))
        #expect(str.contains("/\(ISO_32000.Font.courier.resourceName.rawValue) "))
    }

    @Test
    func `embedded TrueType widths for codes 128 to 159 follow WinAnsi`() throws {
        let fontBytes = try `ISO_32000.Writer Tests`.latoRegular()
        let embedded = try ISO_32000.`9`.`6`.Embedded(data: fontBytes)
        let font = try ISO_32000.Font(embedded: embedded, resourceName: try ISO_32000.COS.Name("CF1"))
        let page = ISO_32000.Page(
            mediaBox: .letter,
            content: ISO_32000.ContentStream { builder in
                builder.beginText()
                builder.setFont(font, size: 12)
                builder.showText("\u{20AC}")
                builder.endText()
            },
            resources: ISO_32000.Resources(fonts: [font.resourceName: font])
        )
        let str = try Self.text(ISO_32000.Document(pages: [page]))

        let start = try #require(str.range(of: "/Widths ["))
        let end = try #require(str[start.upperBound...].firstIndex(of: "]"))
        let widths = str[start.upperBound..<end].split(separator: " ").compactMap { Int($0) }
        #expect(widths.count == 224)

        let metrics = embedded.metrics
        for (code, scalar) in [(0x80, 0x20AC), (0x93, 0x201C), (0x96, 0x2013)] as [(Int, UInt32)] {
            let expected = metrics.width(forCodePoint: scalar) * 1000 / metrics.unitsPerEm
            #expect(metrics.width(forCodePoint: scalar) != metrics.missingWidth)
            #expect(widths[code - 32] == expected, "code \(code)")
        }
    }
}
