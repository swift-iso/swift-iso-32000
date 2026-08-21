public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000 {

    public enum MacExpertEncoding: Encoding {}
}

extension ISO_32000.MacExpertEncoding {

    public static let name: String = "MacExpertEncoding"

    public static let decodeTable: [Unicode.Scalar?] = {
        var table: [Unicode.Scalar?] = Array(repeating: nil, count: 256)

        table[0x20] = "\u{0020}"
        table[0x21] = "\u{0021}"
        table[0x22] = "\u{F721}"
        table[0x23] = "\u{0023}"
        table[0x24] = "\u{0024}"
        table[0x25] = "\u{0025}"
        table[0x26] = "\u{0026}"
        table[0x27] = "\u{00B4}"
        table[0x2A] = "\u{002A}"
        table[0x2B] = "\u{002B}"
        table[0x2C] = "\u{002C}"
        table[0x2D] = "\u{002D}"
        table[0x2E] = "\u{002E}"
        table[0x2F] = "\u{2044}"

        table[0x30] = "\u{0030}"
        table[0x31] = "\u{0031}"
        table[0x32] = "\u{0032}"
        table[0x33] = "\u{0033}"
        table[0x34] = "\u{0034}"
        table[0x35] = "\u{0035}"
        table[0x36] = "\u{0036}"
        table[0x37] = "\u{0037}"
        table[0x38] = "\u{0038}"
        table[0x39] = "\u{0039}"

        table[0x3A] = "\u{003A}"
        table[0x3B] = "\u{003B}"
        table[0x3D] = "\u{F6DE}"
        table[0x3F] = "\u{003F}"

        table[0x5B] = "\u{0028}"
        table[0x5D] = "\u{0029}"

        table[0x61] = "\u{1D00}"
        table[0x62] = "\u{0299}"
        table[0x63] = "\u{1D04}"
        table[0x64] = "\u{1D05}"
        table[0x65] = "\u{1D07}"
        table[0x66] = "\u{A730}"
        table[0x67] = "\u{0262}"
        table[0x68] = "\u{029C}"
        table[0x69] = "\u{026A}"
        table[0x6A] = "\u{1D0A}"
        table[0x6B] = "\u{1D0B}"
        table[0x6C] = "\u{029F}"
        table[0x6D] = "\u{1D0D}"
        table[0x6E] = "\u{0274}"
        table[0x6F] = "\u{1D0F}"
        table[0x70] = "\u{1D18}"

        table[0x72] = "\u{0280}"
        table[0x73] = "\u{A731}"
        table[0x74] = "\u{1D1B}"
        table[0x75] = "\u{1D1C}"
        table[0x76] = "\u{1D20}"
        table[0x77] = "\u{1D21}"

        table[0x79] = "\u{028F}"
        table[0x7A] = "\u{1D22}"

        table[0x44] = "\u{0044}"
        table[0x47] = "\u{00BC}"
        table[0x48] = "\u{00BD}"
        table[0x49] = "\u{00BE}"
        table[0x4A] = "\u{215B}"
        table[0x4B] = "\u{215C}"
        table[0x4C] = "\u{215D}"
        table[0x4D] = "\u{215E}"
        table[0x4E] = "\u{2153}"
        table[0x4F] = "\u{2154}"

        table[0x56] = "\u{FB00}"
        table[0x57] = "\u{FB01}"
        table[0x58] = "\u{FB02}"
        table[0x59] = "\u{FB03}"
        table[0x5A] = "\u{FB04}"

        table[0x28] = "\u{207D}"
        table[0x29] = "\u{207E}"
        table[0x60] = "\u{0060}"

        table[0x89] = "\u{2080}"
        table[0xC1] = "\u{2081}"

        table[0x5E] = "\u{02C6}"
        table[0x7E] = "\u{02DC}"

        table[0xAC] = "\u{00A8}"
        table[0xA6] = "\u{02C7}"
        table[0xC9] = "\u{00B8}"
        table[0xF1] = "\u{02D8}"
        table[0xF2] = "\u{00AF}"
        table[0xF5] = "\u{02D9}"
        table[0xF0] = "\u{02DB}"
        table[0xFB] = "\u{02DA}"

        table[0x87] = "\u{F7E1}"
        table[0x88] = "\u{F7E0}"
        table[0x89] = "\u{F7E2}"
        table[0x8A] = "\u{F7E4}"
        table[0x8B] = "\u{F7E3}"
        table[0x8C] = "\u{F7E5}"
        table[0x8D] = "\u{F7E7}"
        table[0x8E] = "\u{F7E9}"
        table[0x8F] = "\u{F7E8}"
        table[0x90] = "\u{F7EA}"
        table[0x91] = "\u{F7EB}"
        table[0x92] = "\u{F7ED}"
        table[0x93] = "\u{F7EC}"
        table[0x94] = "\u{F7EE}"
        table[0x95] = "\u{F7EF}"
        table[0x96] = "\u{F7F1}"
        table[0x97] = "\u{F7F3}"
        table[0x98] = "\u{F7F2}"
        table[0x99] = "\u{F7F4}"
        table[0x9A] = "\u{F7F6}"
        table[0x9B] = "\u{F7F5}"
        table[0x9C] = "\u{F7FA}"
        table[0x9D] = "\u{F7F9}"
        table[0x9E] = "\u{F7FB}"
        table[0x9F] = "\u{F7FC}"

        table[0xA7] = "\u{0160}"
        table[0xB4] = "\u{F7FD}"
        table[0xBD] = "\u{017D}"
        table[0xBE] = "\u{00C6}"
        table[0xBF] = "\u{00F8}"

        table[0xCF] = "\u{0152}"
        table[0xB9] = "\u{00FE}"
        table[0xC2] = "\u{0141}"

        table[0x7B] = "\u{20A1}"
        table[0x7D] = "\u{20A8}"
        table[0x7C] = "\u{0031}"

        table[0x81] = "\u{F6E9}"
        table[0xED] = "\u{F6EA}"
        table[0xE4] = "\u{F6EB}"
        table[0xE5] = "\u{F6EC}"
        table[0xE9] = "\u{F6ED}"
        table[0xF1] = "\u{F6EE}"
        table[0xF7] = "\u{F6EF}"
        table[0xF6] = "\u{F6F0}"
        table[0xA7] = "\u{F6F1}"
        table[0xE6] = "\u{F6F2}"
        table[0xEA] = "\u{F6F3}"
        table[0xEE] = "\u{F6F4}"

        return table
    }()

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
