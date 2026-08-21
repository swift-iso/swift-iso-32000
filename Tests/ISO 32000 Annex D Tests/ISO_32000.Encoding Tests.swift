import Byte_Primitives
import Foundation
import ISO_32000_Shared
import Testing

@testable import ISO_32000_Annex_D

@Suite
struct `ISO_32000.Encoding Tests` {

    @Suite
    struct CrossEncodingTests {

        @Test
        func `WinAnsi vs PDFDoc Euro position differs`() {

            #expect(ISO_32000.WinAnsiEncoding.decode(0x80) == "\u{20AC}")
            #expect(ISO_32000.PDFDocEncoding.decode(0xA0) == "\u{20AC}")

            #expect(ISO_32000.WinAnsiEncoding.decode(0xA0) != ISO_32000.PDFDocEncoding.decode(0xA0))
        }

        @Test
        func `Standard vs WinAnsi quote handling differs`() {

            #expect(ISO_32000.StandardEncoding.decode(0x27) == "\u{2019}")
            #expect(ISO_32000.WinAnsiEncoding.decode(0x27) == "'")
        }

        @Test
        func `MacRoman vs WinAnsi ligatures at different positions`() {

            #expect(ISO_32000.MacRomanEncoding.decode(0xDE) == "\u{FB01}")
            #expect(ISO_32000.WinAnsiEncoding.decode(0xDE) == "\u{00DE}")
        }

        @Test
        func `All encodings have correct names`() {
            #expect(ISO_32000.WinAnsiEncoding.name == "WinAnsiEncoding")
            #expect(ISO_32000.PDFDocEncoding.name == "PDFDocEncoding")
            #expect(ISO_32000.StandardEncoding.name == "StandardEncoding")
            #expect(ISO_32000.MacRomanEncoding.name == "MacRomanEncoding")
            #expect(ISO_32000.MacExpertEncoding.name == "MacExpertEncoding")
            #expect(ISO_32000.SymbolEncoding.name == "SymbolEncoding")
            #expect(ISO_32000.ZapfDingbatsEncoding.name == "ZapfDingbatsEncoding")
        }
    }

    @Suite
    struct ProtocolConformanceTests {

        @Test
        func `All encodings have decode tables`() {
            #expect(ISO_32000.WinAnsiEncoding.decodeTable.count == 256)
            #expect(ISO_32000.PDFDocEncoding.decodeTable.count == 256)
            #expect(ISO_32000.StandardEncoding.decodeTable.count == 256)
            #expect(ISO_32000.MacRomanEncoding.decodeTable.count == 256)
            #expect(ISO_32000.MacExpertEncoding.decodeTable.count == 256)
            #expect(ISO_32000.SymbolEncoding.decodeTable.count == 256)
            #expect(ISO_32000.ZapfDingbatsEncoding.decodeTable.count == 256)
        }

        @Test
        func `Roundtrip encode-decode for WinAnsi ASCII`() {
            for raw: UInt8 in 0x20...0x7E {
                let byte = Byte(raw)
                if let scalar = ISO_32000.WinAnsiEncoding.decode(byte) {
                    let encoded = ISO_32000.WinAnsiEncoding.encode(scalar)
                    #expect(encoded == byte, "Roundtrip failed for byte \(byte)")
                }
            }
        }

        @Test
        func `Scalar encoding extension`() {
            let scalars = "Hello".unicodeScalars
            let encoded = ISO_32000.WinAnsiEncoding.encode(scalars)
            #expect(encoded == [0x48, 0x65, 0x6C, 0x6C, 0x6F])
        }

        @Test
        func `String init from bytes`() {
            let bytes: [Byte] = [0x48, 0x65, 0x6C, 0x6C, 0x6F]
            let decoded = String(winAnsi: bytes)
            #expect(decoded == "Hello")
        }

        @Test
        func `String init with replacement from bytes`() {
            let bytes: [Byte] = [0x48, 0x65, 0x6C, 0x6C, 0x6F]
            let decoded = String(winAnsi: bytes, withReplacement: true)
            #expect(decoded == "Hello")
        }
    }
}

extension ISO_32000.WinAnsiEncoding {
    @Suite
    struct Test {

        @Test
        func `Euro sign at 0x80`() {

            #expect(ISO_32000.WinAnsiEncoding.encode("\u{20AC}") == 0x80)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x80) == "\u{20AC}")
        }

        @Test
        func `Zcaron at 0x8E (PDF 1.3)`() {
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{017D}") == 0x8E)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x8E) == "\u{017D}")
        }

        @Test
        func `zcaron at 0x9E (PDF 1.3)`() {
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{017E}") == 0x9E)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x9E) == "\u{017E}")
        }

        @Test
        func `Bullet at 0x95`() {

            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2022}") == 0x95)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x95) == "\u{2022}")
        }

        @Test
        func `ASCII range preserved`() {

            #expect(ISO_32000.WinAnsiEncoding.decode(0x20) == " ")
            #expect(ISO_32000.WinAnsiEncoding.decode(0x41) == "A")
            #expect(ISO_32000.WinAnsiEncoding.decode(0x61) == "a")
            #expect(ISO_32000.WinAnsiEncoding.decode(0x7A) == "z")
        }

        @Test
        func `Smart quotes encoding`() {
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2018}") == 0x91)
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2019}") == 0x92)
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{201C}") == 0x93)
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{201D}") == 0x94)
        }

        @Test
        func `Dashes encoding`() {
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2013}") == 0x96)
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2014}") == 0x97)
        }

        @Test
        func `Trademark symbol`() {
            #expect(ISO_32000.WinAnsiEncoding.encode("\u{2122}") == 0x99)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x99) == "\u{2122}")
        }

        @Test
        func `Undefined bytes return nil`() {

            #expect(ISO_32000.WinAnsiEncoding.decode(0x81) == nil)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x8D) == nil)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x8F) == nil)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x90) == nil)
            #expect(ISO_32000.WinAnsiEncoding.decode(0x9D) == nil)
        }

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.WinAnsiEncoding.name == "WinAnsiEncoding")
        }

        @Test
        func `canEncode returns true for encodable scalars`() {
            #expect(ISO_32000.WinAnsiEncoding.canEncode(Unicode.Scalar("A")))
            #expect(ISO_32000.WinAnsiEncoding.canEncode(Unicode.Scalar(0x20AC)!))
            #expect(ISO_32000.WinAnsiEncoding.canEncode(Unicode.Scalar(0x00FC)!))
        }

        @Test
        func `canEncode returns false for non-encodable scalars`() {

            #expect(!ISO_32000.WinAnsiEncoding.canEncode(Unicode.Scalar(0x4F60)!))

            #expect(!ISO_32000.WinAnsiEncoding.canEncode(Unicode.Scalar(0x1F389)!))
        }

        @Test
        func `Collection wrapper isValid`() {
            let validBytes: [Byte] = [0x48, 0x65, 0x6C, 0x6C, 0x6F]
            #expect(validBytes.winAnsi.isValid)
        }
    }
}

extension ISO_32000.PDFDocEncoding {
    @Suite
    struct Test {

        @Test
        func `Euro at 0xA0 differs from WinAnsi`() {

            #expect(ISO_32000.PDFDocEncoding.decode(0xA0) == "\u{20AC}")

        }

        @Test
        func `Bullet at 0x80`() {

            #expect(ISO_32000.PDFDocEncoding.decode(0x80) == "\u{2022}")
        }

        @Test
        func `Diacritics in 0x18-0x1F range`() {

            #expect(ISO_32000.PDFDocEncoding.decode(0x18) == "\u{02D8}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x19) == "\u{02C7}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1A) == "\u{02C6}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1B) == "\u{02D9}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1C) == "\u{02DD}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1D) == "\u{02DB}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1E) == "\u{02DA}")
            #expect(ISO_32000.PDFDocEncoding.decode(0x1F) == "\u{02DC}")
        }

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.PDFDocEncoding.name == "PDFDocEncoding")
        }

        @Test
        func `Complete 256-byte mapping`() {

            var definedCount = 0
            for byte in 0..<256 {
                if ISO_32000.PDFDocEncoding.decode(Byte(UInt8(byte))) != nil {
                    definedCount += 1
                }
            }

            #expect(definedCount > 200)
        }

        @Test
        func `detectEncoding UTF16BE`() {
            let utf16Data: [Byte] = [0xFE, 0xFF, 0x00, 0x48]
            let detected = ISO_32000.PDFDocEncoding.detectEncoding(utf16Data)
            #expect(detected == .utf16BE)
        }

        @Test
        func `detectEncoding UTF8`() {
            let utf8Data: [Byte] = [0xEF, 0xBB, 0xBF, 0x48]
            let detected = ISO_32000.PDFDocEncoding.detectEncoding(utf8Data)
            #expect(detected == .utf8)
        }

        @Test
        func `detectEncoding PDFDocEncoding`() {
            let pdfDocData: [Byte] = [0x48, 0x65, 0x6C, 0x6C, 0x6F]
            let detected = ISO_32000.PDFDocEncoding.detectEncoding(pdfDocData)
            #expect(detected == .pdfDocEncoding)
        }
    }
}

extension ISO_32000.StandardEncoding {
    @Suite
    struct Test {

        @Test
        func `Encoding name not predefined`() {

            #expect(ISO_32000.StandardEncoding.name == "StandardEncoding")
        }

        @Test
        func `Quote characters differ from ASCII`() {

            #expect(ISO_32000.StandardEncoding.decode(0x27) == "\u{2019}")

            #expect(ISO_32000.StandardEncoding.decode(0x60) == "\u{2018}")
        }

        @Test
        func `Ligatures in extended range`() {
            #expect(ISO_32000.StandardEncoding.decode(0xAE) == "\u{FB01}")
            #expect(ISO_32000.StandardEncoding.decode(0xAF) == "\u{FB02}")
        }

        @Test
        func `Fraction slash`() {
            #expect(ISO_32000.StandardEncoding.decode(0xA4) == "\u{2044}")
        }

        @Test
        func `Em dash`() {
            #expect(ISO_32000.StandardEncoding.decode(0xD0) == "\u{2014}")
        }

        @Test
        func `ASCII letters preserved`() {
            #expect(ISO_32000.StandardEncoding.decode(0x41) == "A")
            #expect(ISO_32000.StandardEncoding.decode(0x5A) == "Z")
            #expect(ISO_32000.StandardEncoding.decode(0x61) == "a")
            #expect(ISO_32000.StandardEncoding.decode(0x7A) == "z")
        }

        @Test
        func `Many positions undefined`() {

            #expect(ISO_32000.StandardEncoding.decode(0x00) == nil)
            #expect(ISO_32000.StandardEncoding.decode(0x7F) == nil)
            #expect(ISO_32000.StandardEncoding.decode(0x80) == nil)
        }
    }
}

extension ISO_32000.MacRomanEncoding {
    @Suite
    struct Test {

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.MacRomanEncoding.name == "MacRomanEncoding")
        }

        @Test
        func `Currency symbol at 0xDB not Euro`() {

            #expect(ISO_32000.MacRomanEncoding.decode(0xDB) == "\u{00A4}")
        }

        @Test
        func `Non-breaking space at 0xCA`() {

            #expect(ISO_32000.MacRomanEncoding.decode(0xCA) == "\u{00A0}")
        }

        @Test
        func `Extended ASCII characters`() {
            #expect(ISO_32000.MacRomanEncoding.decode(0x80) == "\u{00C4}")
            #expect(ISO_32000.MacRomanEncoding.decode(0x81) == "\u{00C5}")
            #expect(ISO_32000.MacRomanEncoding.decode(0x82) == "\u{00C7}")
            #expect(ISO_32000.MacRomanEncoding.decode(0x83) == "\u{00C9}")
        }

        @Test
        func `Ligatures`() {
            #expect(ISO_32000.MacRomanEncoding.decode(0xDE) == "\u{FB01}")
            #expect(ISO_32000.MacRomanEncoding.decode(0xDF) == "\u{FB02}")
        }

        @Test
        func `ASCII range preserved`() {
            #expect(ISO_32000.MacRomanEncoding.decode(0x20) == " ")
            #expect(ISO_32000.MacRomanEncoding.decode(0x41) == "A")
            #expect(ISO_32000.MacRomanEncoding.decode(0x7E) == "~")
        }
    }
}

extension ISO_32000.MacExpertEncoding {
    @Suite
    struct Test {

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.MacExpertEncoding.name == "MacExpertEncoding")
        }

        @Test
        func `Small capitals`() {

            #expect(ISO_32000.MacExpertEncoding.decode(0x61) == "\u{1D00}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x62) == "\u{0299}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x63) == "\u{1D04}")
        }

        @Test
        func `Ligatures`() {
            #expect(ISO_32000.MacExpertEncoding.decode(0x56) == "\u{FB00}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x57) == "\u{FB01}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x58) == "\u{FB02}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x59) == "\u{FB03}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x5A) == "\u{FB04}")
        }

        @Test
        func `Fractions`() {
            #expect(ISO_32000.MacExpertEncoding.decode(0x47) == "\u{00BC}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x48) == "\u{00BD}")
            #expect(ISO_32000.MacExpertEncoding.decode(0x49) == "\u{00BE}")
        }

        @Test
        func `Oldstyle digits`() {
            #expect(ISO_32000.MacExpertEncoding.decode(0x30) == "0")
            #expect(ISO_32000.MacExpertEncoding.decode(0x31) == "1")
            #expect(ISO_32000.MacExpertEncoding.decode(0x39) == "9")
        }

        @Test
        func `Fraction slash`() {
            #expect(ISO_32000.MacExpertEncoding.decode(0x2F) == "\u{2044}")
        }
    }
}

extension ISO_32000.SymbolEncoding {
    @Suite
    struct Test {

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.SymbolEncoding.name == "SymbolEncoding")
        }

        @Test
        func `Greek uppercase letters`() {
            #expect(ISO_32000.SymbolEncoding.decode(0x41) == "\u{0391}")
            #expect(ISO_32000.SymbolEncoding.decode(0x42) == "\u{0392}")
            #expect(ISO_32000.SymbolEncoding.decode(0x47) == "\u{0393}")
            #expect(ISO_32000.SymbolEncoding.decode(0x44) == "\u{0394}")
            #expect(ISO_32000.SymbolEncoding.decode(0x57) == "\u{03A9}")
        }

        @Test
        func `Greek lowercase letters`() {
            #expect(ISO_32000.SymbolEncoding.decode(0x61) == "\u{03B1}")
            #expect(ISO_32000.SymbolEncoding.decode(0x62) == "\u{03B2}")
            #expect(ISO_32000.SymbolEncoding.decode(0x67) == "\u{03B3}")
            #expect(ISO_32000.SymbolEncoding.decode(0x64) == "\u{03B4}")
            #expect(ISO_32000.SymbolEncoding.decode(0x77) == "\u{03C9}")
        }

        @Test
        func `Mathematical symbols`() {
            #expect(ISO_32000.SymbolEncoding.decode(0xB1) == "\u{00B1}")
            #expect(ISO_32000.SymbolEncoding.decode(0xB4) == "\u{00D7}")
            #expect(ISO_32000.SymbolEncoding.decode(0xB8) == "\u{00F7}")
            #expect(ISO_32000.SymbolEncoding.decode(0xB9) == "\u{2260}")
        }

        @Test
        func `Set theory symbols`() {
            #expect(ISO_32000.SymbolEncoding.decode(0xC7) == "\u{2229}")
            #expect(ISO_32000.SymbolEncoding.decode(0xC8) == "\u{222A}")
            #expect(ISO_32000.SymbolEncoding.decode(0xCE) == "\u{2208}")
            #expect(ISO_32000.SymbolEncoding.decode(0xCF) == "\u{2209}")
        }

        @Test
        func `Logic symbols`() {

            #expect(ISO_32000.SymbolEncoding.decode(0xD9) == "\u{2227}")

            #expect(ISO_32000.SymbolEncoding.decode(0xDB) == "\u{21D4}")
        }

        @Test
        func `Pi and infinity`() {
            #expect(ISO_32000.SymbolEncoding.decode(0x70) == "\u{03C0}")
            #expect(ISO_32000.SymbolEncoding.decode(0xA5) == "\u{221E}")
        }

        @Test
        func `Digits preserved`() {
            #expect(ISO_32000.SymbolEncoding.decode(0x30) == "0")
            #expect(ISO_32000.SymbolEncoding.decode(0x39) == "9")
        }
    }
}

extension ISO_32000.ZapfDingbatsEncoding {
    @Suite
    struct Test {

        @Test
        func `Encoding name`() {
            #expect(ISO_32000.ZapfDingbatsEncoding.name == "ZapfDingbatsEncoding")
        }

        @Test
        func `Scissors and pointing hands`() {
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x21) == "\u{2701}")

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x2A) == "\u{261B}")

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x2D) == "\u{270D}")
        }

        @Test
        func `Checkmarks and crosses`() {
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x33) == "\u{2713}")
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x37) == "\u{2717}")
        }

        @Test
        func `Stars`() {

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x48) == "\u{2605}")

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0x49) == "\u{2729}")
        }

        @Test
        func `Playing card suits`() {

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xA8) == "\u{2663}")
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xA9) == "\u{2666}")
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xAA) == "\u{2665}")
            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xAB) == "\u{2660}")
        }

        @Test
        func `Circled numbers`() {

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xAC) != nil)
        }

        @Test
        func `Arrows`() {

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xD4) == "\u{2794}")

            #expect(ISO_32000.ZapfDingbatsEncoding.decode(0xD5) == "\u{2192}")
        }

        @Test
        func `Dingbats Unicode block`() {

            if let scissors = ISO_32000.ZapfDingbatsEncoding.decode(0x21) {
                let value = scissors.value
                #expect(value >= 0x2700 && value <= 0x27BF)
            }
        }
    }
}
