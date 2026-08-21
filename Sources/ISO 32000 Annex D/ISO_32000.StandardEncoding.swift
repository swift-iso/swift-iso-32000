public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000 {

    public enum StandardEncoding: Encoding {}
}

extension ISO_32000.StandardEncoding {

    public static let name: String = "StandardEncoding"

    public static let decodeTable: [Unicode.Scalar?] = [

        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,

        "\u{0020}",
        "\u{0021}",
        "\u{0022}",
        "\u{0023}",
        "\u{0024}",
        "\u{0025}",
        "\u{0026}",
        "\u{2019}",
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

        "\u{2018}",
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

        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,

        nil,
        "\u{00A1}",
        "\u{00A2}",
        "\u{00A3}",
        "\u{2044}",
        "\u{00A5}",
        "\u{0192}",
        "\u{00A7}",
        "\u{00A4}",
        "\u{0027}",
        "\u{201C}",
        "\u{00AB}",
        "\u{2039}",
        "\u{203A}",
        "\u{FB01}",
        "\u{FB02}",

        nil,
        "\u{2013}",
        "\u{2020}",
        "\u{2021}",
        "\u{00B7}",
        nil,
        "\u{00B6}",
        "\u{2022}",
        "\u{201A}",
        "\u{201E}",
        "\u{201D}",
        "\u{00BB}",
        "\u{2026}",
        "\u{2030}",
        nil,
        "\u{00BF}",

        nil,
        "\u{0060}",
        "\u{00B4}",
        "\u{02C6}",
        "\u{02DC}",
        "\u{00AF}",
        "\u{02D8}",
        "\u{02D9}",
        "\u{00A8}",
        nil,
        "\u{02DA}",
        "\u{00B8}",
        nil,
        "\u{02DD}",
        "\u{02DB}",
        "\u{02C7}",

        "\u{2014}",
        nil, nil, nil, nil, nil, nil, nil,
        nil, nil, nil, nil, nil, nil, nil, nil,

        nil,
        "\u{00C6}",
        nil,
        "\u{00AA}",
        nil, nil, nil, nil,
        "\u{0141}",
        "\u{00D8}",
        "\u{0152}",
        "\u{00BA}",
        nil, nil, nil, nil,

        nil,
        "\u{00E6}",
        nil, nil, nil,
        "\u{0131}",
        nil, nil,
        "\u{0142}",
        "\u{00F8}",
        "\u{0153}",
        "\u{00DF}",
        nil, nil, nil, nil,
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
