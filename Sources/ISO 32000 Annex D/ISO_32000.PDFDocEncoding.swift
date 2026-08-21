public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000 {

    public enum PDFDocEncoding: Encoding {}
}

extension ISO_32000.PDFDocEncoding {

    public static let name: String = "PDFDocEncoding"

    public static let decodeTable: [Unicode.Scalar?] = [

        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        "\u{0009}",
        "\u{000A}",
        nil,
        nil,
        "\u{000D}",
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,

        "\u{02D8}",
        "\u{02C7}",
        "\u{02C6}",
        "\u{02D9}",
        "\u{02DD}",
        "\u{02DB}",
        "\u{02DA}",
        "\u{02DC}",

        "\u{0020}",
        "\u{0021}",
        "\u{0022}",
        "\u{0023}",
        "\u{0024}",
        "\u{0025}",
        "\u{0026}",
        "\u{0027}",
        "\u{0028}",
        "\u{0029}",
        "\u{002A}",
        "\u{002B}",
        "\u{002C}",
        "\u{002D}",
        "\u{002E}",
        "\u{002F}",
        "\u{0030}",
        "\u{0031}",
        "\u{0032}",
        "\u{0033}",
        "\u{0034}",
        "\u{0035}",
        "\u{0036}",
        "\u{0037}",
        "\u{0038}",
        "\u{0039}",
        "\u{003A}",
        "\u{003B}",
        "\u{003C}",
        "\u{003D}",
        "\u{003E}",
        "\u{003F}",

        "\u{0040}",
        "\u{0041}",
        "\u{0042}",
        "\u{0043}",
        "\u{0044}",
        "\u{0045}",
        "\u{0046}",
        "\u{0047}",
        "\u{0048}",
        "\u{0049}",
        "\u{004A}",
        "\u{004B}",
        "\u{004C}",
        "\u{004D}",
        "\u{004E}",
        "\u{004F}",
        "\u{0050}",
        "\u{0051}",
        "\u{0052}",
        "\u{0053}",
        "\u{0054}",
        "\u{0055}",
        "\u{0056}",
        "\u{0057}",
        "\u{0058}",
        "\u{0059}",
        "\u{005A}",
        "\u{005B}",
        "\u{005C}",
        "\u{005D}",
        "\u{005E}",
        "\u{005F}",

        "\u{0060}",
        "\u{0061}",
        "\u{0062}",
        "\u{0063}",
        "\u{0064}",
        "\u{0065}",
        "\u{0066}",
        "\u{0067}",
        "\u{0068}",
        "\u{0069}",
        "\u{006A}",
        "\u{006B}",
        "\u{006C}",
        "\u{006D}",
        "\u{006E}",
        "\u{006F}",
        "\u{0070}",
        "\u{0071}",
        "\u{0072}",
        "\u{0073}",
        "\u{0074}",
        "\u{0075}",
        "\u{0076}",
        "\u{0077}",
        "\u{0078}",
        "\u{0079}",
        "\u{007A}",
        "\u{007B}",
        "\u{007C}",
        "\u{007D}",
        "\u{007E}",
        nil,

        "\u{2022}",
        "\u{2020}",
        "\u{2021}",
        "\u{2026}",
        "\u{2014}",
        "\u{2013}",
        "\u{0192}",
        "\u{2044}",
        "\u{2039}",
        "\u{203A}",
        "\u{2212}",
        "\u{2030}",
        "\u{201E}",
        "\u{201C}",
        "\u{201D}",
        "\u{2018}",
        "\u{2019}",
        "\u{201A}",
        "\u{2122}",
        "\u{FB01}",
        "\u{FB02}",
        "\u{0141}",
        "\u{0152}",
        "\u{0160}",
        "\u{0178}",
        "\u{017D}",
        "\u{0131}",
        "\u{0142}",
        "\u{0153}",
        "\u{0161}",
        "\u{017E}",
        nil,

        "\u{20AC}",
        "\u{00A1}",
        "\u{00A2}",
        "\u{00A3}",
        "\u{00A4}",
        "\u{00A5}",
        "\u{00A6}",
        "\u{00A7}",
        "\u{00A8}",
        "\u{00A9}",
        "\u{00AA}",
        "\u{00AB}",
        "\u{00AC}",
        nil,
        "\u{00AE}",
        "\u{00AF}",
        "\u{00B0}",
        "\u{00B1}",
        "\u{00B2}",
        "\u{00B3}",
        "\u{00B4}",
        "\u{00B5}",
        "\u{00B6}",
        "\u{00B7}",
        "\u{00B8}",
        "\u{00B9}",
        "\u{00BA}",
        "\u{00BB}",
        "\u{00BC}",
        "\u{00BD}",
        "\u{00BE}",
        "\u{00BF}",

        "\u{00C0}",
        "\u{00C1}",
        "\u{00C2}",
        "\u{00C3}",
        "\u{00C4}",
        "\u{00C5}",
        "\u{00C6}",
        "\u{00C7}",
        "\u{00C8}",
        "\u{00C9}",
        "\u{00CA}",
        "\u{00CB}",
        "\u{00CC}",
        "\u{00CD}",
        "\u{00CE}",
        "\u{00CF}",
        "\u{00D0}",
        "\u{00D1}",
        "\u{00D2}",
        "\u{00D3}",
        "\u{00D4}",
        "\u{00D5}",
        "\u{00D6}",
        "\u{00D7}",
        "\u{00D8}",
        "\u{00D9}",
        "\u{00DA}",
        "\u{00DB}",
        "\u{00DC}",
        "\u{00DD}",
        "\u{00DE}",
        "\u{00DF}",

        "\u{00E0}",
        "\u{00E1}",
        "\u{00E2}",
        "\u{00E3}",
        "\u{00E4}",
        "\u{00E5}",
        "\u{00E6}",
        "\u{00E7}",
        "\u{00E8}",
        "\u{00E9}",
        "\u{00EA}",
        "\u{00EB}",
        "\u{00EC}",
        "\u{00ED}",
        "\u{00EE}",
        "\u{00EF}",
        "\u{00F0}",
        "\u{00F1}",
        "\u{00F2}",
        "\u{00F3}",
        "\u{00F4}",
        "\u{00F5}",
        "\u{00F6}",
        "\u{00F7}",
        "\u{00F8}",
        "\u{00F9}",
        "\u{00FA}",
        "\u{00FB}",
        "\u{00FC}",
        "\u{00FD}",
        "\u{00FE}",
        "\u{00FF}",
    ]

    @usableFromInline
    static let encodeTable: [UInt32: Byte] = {
        var table: [UInt32: Byte] = [:]
        for (byte, scalar) in decodeTable.enumerated() {
            if let scalar {
                table[scalar.value] = Byte(UInt8(byte))
            }
        }
        return table
    }()

    @inlinable
    public static func encode(_ scalar: Unicode.Scalar) -> Byte? {
        encodeTable[scalar.value]
    }

    @inlinable
    public static func decode(_ byte: Byte) -> Unicode.Scalar? {
        decodeTable[Int(byte.underlying)]
    }
}

extension ISO_32000.PDFDocEncoding {

    public static func detectEncoding<C: Collection>(_ bytes: C) -> TextStringEncoding
    where C.Element == Byte {
        var iterator = bytes.makeIterator()

        guard let first = iterator.next() else {
            return .pdfDocEncoding
        }

        guard let second = iterator.next() else {
            return .pdfDocEncoding
        }

        if first == 0xFE && second == 0xFF {
            return .utf16BE
        }

        if first == 0xEF && second == 0xBB {
            if let third = iterator.next(), third == 0xBF {
                return .utf8
            }
        }

        return .pdfDocEncoding
    }

    public enum TextStringEncoding: Sendable {

        case pdfDocEncoding

        case utf16BE

        case utf8
    }
}
