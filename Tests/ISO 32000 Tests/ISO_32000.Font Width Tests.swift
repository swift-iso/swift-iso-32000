import Byte
import Testing

@testable import ISO_32000

extension ISO_32000.Font {

    @Suite
    struct `Width Correctness` {

        struct Case: Sendable, CustomTestStringConvertible {
            let text: String
            let designUnits: Double

            var testDescription: String { "\(text.unicodeScalars.count) scalars" }
        }

        static let cases: [Case] = [
            Case(text: "", designUnits: 0),
            Case(text: "Hello Worl", designUnits: 4611),
            Case(text: "Hello World", designUnits: 5167),
            Case(text: String(repeating: "Lorem ipsum dolor sit amet. ", count: 4), designUnits: 50460),
            Case(text: String(repeating: "a", count: 100), designUnits: 55600),
            Case(text: String(repeating: "a", count: 1000), designUnits: 556000),
            Case(text: "a\u{2026}", designUnits: 1556),
        ]

        @Test(arguments: cases)
        func `Helvetica string width at 1000 pt equals the summed AFM widths`(_ c: Case) {
            #expect(ISO_32000.Font.helvetica.width(of: c.text, atSize: 1000).underlying == c.designUnits)
        }

        @Test(arguments: cases)
        func `Helvetica WinAnsi byte width equals the string width of the same text`(_ c: Case) {
            let bytes = c.text.unicodeScalars.compactMap(ISO_32000.WinAnsiEncoding.encode)
            #expect(bytes.count == c.text.unicodeScalars.count)
            #expect(ISO_32000.Font.helvetica.winAnsi.width(of: bytes, atSize: 1000).underlying == c.designUnits)
        }

        @Test
        func `WinAnsi byte 0x85 is the ellipsis at 1000 units`() {
            let bytes: [Byte] = [0x61, 0x85].map(Byte.init(bitPattern:))
            #expect(ISO_32000.Font.helvetica.winAnsi.width(of: bytes, atSize: 1000).underlying == 1556)
        }

        @Test
        func `width at 12 pt is the AFM sum scaled and quantized to 0.01 user-space units`() {
            #expect(ISO_32000.Font.helvetica.width(of: "Hello World", atSize: 12).underlying == 62.0)
            #expect(ISO_32000.Font.helvetica.width(of: "a", atSize: 12).underlying == 6.67)
        }
    }
}
