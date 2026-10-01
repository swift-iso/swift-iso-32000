import Foundation
import ISO_14496_22
import Testing

@testable import ISO_32000
@testable import ISO_32000_9_Text
@testable import ISO_32000_Flate

@Suite
struct `ISO_32000.Writer Tests` {

    @Test
    func `Writes valid PDF header`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.hasPrefix("%PDF-1.7"))
    }

    @Test
    func `Includes binary marker after header`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)

        let headerEnd = pdf.firstIndex(of: Byte(UInt8(ascii: "\n")))!
        let markerStart = pdf.index(after: headerEnd)
        #expect(UInt8(bitPattern: pdf[pdf.index(after: markerStart)]) > 127)
    }

    @Test
    func `Writes catalog object`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Type /Catalog"))
    }

    @Test
    func `Writes pages object`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Type /Pages"))
        #expect(str.contains("/Count 1"))
    }

    @Test
    func `Writes page object`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Type /Page"))
        #expect(str.contains("/MediaBox"))
    }

    @Test
    func `Writes cross-reference table`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("xref"))
        #expect(str.contains("0000000000 65535 f"))
    }

    @Test
    func `Writes trailer`() {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("trailer"))
        #expect(str.contains("/Size"))
        #expect(str.contains("/Root"))
        #expect(str.contains("startxref"))
        #expect(str.contains("%%EOF"))
    }

    @Test(arguments: [
        (ISO_32000.UserSpace.Rectangle.letter, 612.0, 792.0),
        (.a4, 595.276, 841.89),
        (.legal, 612.0, 1008.0),
    ])
    func `Writes correct MediaBox for paper sizes`(
        rect: ISO_32000.UserSpace.Rectangle,
        width: Double,
        height: Double
    ) {
        let document = ISO_32000.Document(
            pages: [ISO_32000.Page.empty(size: rect)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/MediaBox"))
    }

    @Test
    func `Writes document info`() {
        let document = ISO_32000.Document(
            info: ISO_32000.Document.Info(
                title: "Test Document",
                author: "Swift PDF",
                creator: "swift-iso-32000"
            ),
            pages: [ISO_32000.Page.empty(size: .letter)]
        )
        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Title"))
        #expect(str.contains("/Author"))
        #expect(str.contains("/Creator"))
        #expect(str.contains("/Info"))
    }

    @Test
    func `Writes compressed content with FlateDecode`() {
        let content = ISO_32000.ContentStream { builder in
            builder.beginText()
            builder.setFont(ISO_32000.Font.helvetica, size: 12)
            for i in 0..<20 {
                builder.moveText(
                    dx: .init(72),
                    dy: .init(Double(700 - i * 20))
                )
                builder.showText(
                    "Line \(i): This is test content for compression testing purposes."
                )
            }
            builder.endText()
        }

        let document = ISO_32000.Document(
            pages: [
                ISO_32000.Page(
                    mediaBox: .letter,
                    content: content,
                    resources: ISO_32000.Resources(fonts: [
                        ISO_32000.Font.helvetica.resourceName: ISO_32000.Font.helvetica
                    ])
                )
            ]
        )

        var writer = ISO_32000.Writer.flate()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Filter /FlateDecode"))
    }

    @Test
    func `Writes multi-page document`() {
        let page1 = ISO_32000.Page.empty(size: .letter)
        let page2 = ISO_32000.Page.empty(size: .letter)

        let document = ISO_32000.Document(pages: [page1, page2])

        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)
        let str = String(decoding: pdf, as: UTF8.self)

        #expect(str.contains("/Count 2"))
    }

    @Test
    func `Outputs simple PDF for inspection`() throws {
        let document = ISO_32000.Document(
            info: ISO_32000.Document.Info(
                title: "Test Document",
                creator: "swift-iso-32000 tests"
            ),
            pages: [
                ISO_32000.Page(
                    mediaBox: .letter,
                    content: ISO_32000.ContentStream { builder in
                        builder.beginText()
                        builder.setFont(ISO_32000.Font.helvetica, size: 24)
                        builder.moveText(dx: .init(72), dy: .init(700))
                        builder.showText("ISO 32000 Test Document")

                        builder.setFont(ISO_32000.Font.helvetica, size: 12)
                        builder.moveText(dx: .init(0), dy: .init(-30))
                        builder.showText("This PDF was generated by swift-iso-32000.")
                        builder.endText()
                    },
                    resources: ISO_32000.Resources(fonts: [
                        ISO_32000.Font.helvetica.resourceName: ISO_32000.Font.helvetica
                    ])
                )
            ]
        )

        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)

        #expect(!pdf.isEmpty)
    }

    @Test
    func `Outputs all Standard 14 fonts for inspection`() throws {
        var contentBuilder = ISO_32000.ContentStream.Builder()
        contentBuilder.beginText()

        var dy: ISO_32000.UserSpace.Dy = .init(700)
        var fonts: [ISO_32000.COS.Name: ISO_32000.Font] = [:]

        for pdfFont in ISO_32000.Font.standard14 {
            fonts[pdfFont.resourceName] = pdfFont

            contentBuilder.setFont(pdfFont, size: 14)
            contentBuilder.moveText(dx: .init(72), dy: dy)
            contentBuilder.showText(
                "\(pdfFont.baseFontName.rawValue): The quick brown fox jumps over the lazy dog."
            )
            dy = .init(-30)
            contentBuilder.moveText(dx: .init(-72), dy: .init(0))
        }

        contentBuilder.endText()

        let document = ISO_32000.Document(
            info: ISO_32000.Document.Info(title: "Standard 14 Fonts"),
            pages: [
                ISO_32000.Page(
                    mediaBox: .letter,
                    content: ISO_32000.ContentStream(data: contentBuilder.data),
                    resources: ISO_32000.Resources(fonts: fonts)
                )
            ]
        )

        var writer = ISO_32000.Writer()
        let pdf = writer.write(document)

        #expect(!pdf.isEmpty)
    }

    #if os(macOS)
        static func latoRegular() throws -> [Byte] {
            let url = try #require(
                Bundle.module.url(forResource: "Lato-Regular", withExtension: "ttf", subdirectory: "Fixtures"),
                "Packaged font fixture Fixtures/Lato-Regular.ttf is missing from the test bundle"
            )
            let bytes = try Data(contentsOf: url).map(Byte.init(bitPattern:))
            #expect(bytes.count == 96184, "Fixture is not the recorded Lato-Regular.ttf (see Fixtures/PROVENANCE.md)")
            return bytes
        }

        @Test
        func `embeds the full TrueType program of the packaged Lato fixture`() throws {
            let fontBytes = try Self.latoRegular()

            let customFont = try ISO_32000.Font(
                data: fontBytes,
                resourceName: try ISO_32000.COS.Name("CF1")
            )
            let helvetica = ISO_32000.Font.helvetica

            let document = ISO_32000.Document(
                info: ISO_32000.Document.Info(
                    title: "Embedded TrueType Font Test",
                    creator: "swift-iso-32000 tests"
                ),
                pages: [
                    ISO_32000.Page(
                        mediaBox: .letter,
                        content: ISO_32000.ContentStream { builder in
                            builder.beginText()
                            builder.setFont(customFont, size: 24)
                            builder.moveText(dx: .init(72), dy: .init(700))
                            builder.showText("Embedded TrueType Font: Lato")
                            builder.setFont(customFont, size: 14)
                            builder.moveText(dx: .init(0), dy: .init(-30))
                            builder.showText("The quick brown fox jumps over the lazy dog.")
                            builder.moveText(dx: .init(0), dy: .init(-25))
                            builder.showText("0123456789 !@#$%^&*()[]{}|;':\",./<>?")
                            builder.setFont(helvetica, size: 14)
                            builder.moveText(dx: .init(0), dy: .init(-50))
                            builder.showText("The quick brown fox jumps over the lazy dog.")
                            builder.endText()
                        },
                        resources: ISO_32000.Resources(fonts: [
                            customFont.resourceName: customFont,
                            helvetica.resourceName: helvetica,
                        ])
                    )
                ]
            )

            var writer = ISO_32000.Writer()
            let pdf = writer.write(document)
            let str = String(decoding: pdf, as: UTF8.self)

            #expect(pdf.count > fontBytes.count, "PDF \(pdf.count) bytes must carry the whole \(fontBytes.count)-byte program")
            #expect(str.contains("/Subtype /TrueType"))
            #expect(str.contains("/FontFile2"))
            #expect(str.contains("/FontDescriptor"))
            #expect(str.contains("/Lato-Regular"))
            #expect(str.contains("/Length1 \(fontBytes.count)"))
        }

        @Test
        func `subsetting the packaged Lato fixture keeps exactly the used glyphs`() throws {
            let fontBytes = try Self.latoRegular()
            let fullEmbedded = try ISO_32000.`9`.`6`.Embedded(data: fontBytes)
            let fullSize = fullEmbedded.data.count

            let lines = [
                "Subsetted Font: Lato",
                "Hello World! This is a subset font test.",
                "The font above has been subsetted.",
                "It only contains glyphs for the characters used.",
            ]
            let usedChars = Set(lines.joined())

            let subsetEmbedded = try fullEmbedded.subsetted(for: usedChars)
            let subsetSize = subsetEmbedded.data.count
            let full = fullEmbedded.fontFile
            let subset = subsetEmbedded.fontFile

            let usedGlyphs = Set(usedChars.compactMap { full.glyphIndex(for: $0.unicodeScalars.first!.value) })
            #expect(usedGlyphs.count == usedChars.count)
            #expect(full.numGlyphs == 277)
            #expect(Int(subset.numGlyphs) == usedGlyphs.count + 1, "subset keeps .notdef plus one glyph per used character")

            for character in usedChars {
                let codePoint = character.unicodeScalars.first!.value
                #expect(subset.glyphIndex(for: codePoint) != nil, "subset lost \(character)")
                #expect(subset.advanceWidth(for: codePoint) == full.advanceWidth(for: codePoint), "advance of \(character) changed")
            }
            for unused in "qzQZ0" {
                let codePoint = unused.unicodeScalars.first!.value
                #expect(full.glyphIndex(for: codePoint) != nil)
                #expect(subset.glyphIndex(for: codePoint) == nil, "subset kept unused \(unused)")
            }

            #expect(subsetSize < fullSize / 5, "subset \(subsetSize) of \(fullSize) bytes")

            let customFont = try ISO_32000.Font(
                embedded: subsetEmbedded,
                resourceName: try ISO_32000.COS.Name("CF1")
            )

            let document = ISO_32000.Document(
                info: ISO_32000.Document.Info(
                    title: "Subsetted TrueType Font Test",
                    creator: "swift-iso-32000 tests"
                ),
                pages: [
                    ISO_32000.Page(
                        mediaBox: .letter,
                        content: ISO_32000.ContentStream { builder in
                            builder.beginText()
                            builder.setFont(customFont, size: 14)
                            builder.moveText(dx: .init(72), dy: .init(700))
                            for line in lines {
                                builder.showText(line)
                                builder.moveText(dx: .init(0), dy: .init(-25))
                            }
                            builder.endText()
                        },
                        resources: ISO_32000.Resources(fonts: [
                            customFont.resourceName: customFont
                        ])
                    )
                ]
            )

            var writer = ISO_32000.Writer()
            let pdf = writer.write(document)
            let str = String(decoding: pdf, as: UTF8.self)

            #expect(pdf.count < fullSize, "PDF \(pdf.count) bytes must be smaller than the full \(fullSize)-byte program")
            #expect(str.contains("/FontFile2"))
            #expect(str.contains("/Length1 \(subsetSize)"))
        }
    #endif
}
