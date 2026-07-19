// ISO_32000.COS.StringValue Astral Plane Tests.swift
//
// Fable-448 F-003 regression coverage: `asHexadecimal()` traps for scalars
// beyond U+FFFF (astral plane, e.g. emoji), and the `pdfStringBytes(_:)`
// UTF-16BE parser silently dropped every surrogate-pair code unit instead
// of reassembling it into its scalar. Both surfaces are exercised here;
// `serialize(_:into:)` and `asLiteral()` already have surrogate-pair
// coverage in "ISO_32000.COS.StringValue.NonASCII Tests.swift".

import RFC_4648
import Testing

@testable import ISO_32000

extension ISO_32000.COS.StringValue {
    @Suite struct Tests {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

extension ISO_32000.COS.StringValue.Tests.Unit {
    @Test
    func `asHexadecimal on a PDFDocEncoding-only payload`() {
        let str = ISO_32000.COS.StringValue("Hi")
        // 'H' = 0x48, 'i' = 0x69
        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<4869>")
    }
}

extension ISO_32000.COS.StringValue.Tests.`Edge Case` {
    // F-003, defect 1: `asHexadecimal()` used to narrow `scalar.value` (a
    // UInt32) straight into a `UInt16`, which traps for any astral-plane
    // scalar (U+10000...U+10FFFF, e.g. emoji) since its raw value exceeds
    // UInt16.max. Iterating `.utf16` instead naturally splits the scalar
    // into its surrogate pair, matching `asLiteral()`'s existing behavior.
    @Test
    func `asHexadecimal does not trap on an astral-plane scalar`() {
        // U+1F600 GRINNING FACE — UTF-16 surrogate pair: high 0xD83D, low 0xDE00.
        let str = ISO_32000.COS.StringValue("\u{1F600}")
        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<FEFFD83DDE00>")
    }

    @Test
    func `asHexadecimal does not trap on a mixed BMP and astral-plane payload`() {
        let str = ISO_32000.COS.StringValue("A\u{1F600}B")
        // BOM, 'A' (0041), high/low surrogate, 'B' (0042).
        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<FEFF0041D83DDE000042>")
    }

    // F-003, defect 2: the UTF-16BE branch of `StringValue(pdfStringBytes:)`
    // resolved each 16-bit code unit to a `Unicode.Scalar` independently.
    // `Unicode.Scalar(UInt16)` returns nil for every value in the surrogate
    // range (0xD800...0xDFFF), so both code units of any surrogate pair
    // were silently dropped instead of being reassembled into the
    // astral-plane scalar they encode.
    @Test
    func `pdfStringBytes reassembles a surrogate pair into its astral-plane scalar`() {
        // BOM + high surrogate (D83D) + low surrogate (DE00) == U+1F600.
        let bytes: [Byte] = [0xFE, 0xFF, 0xD8, 0x3D, 0xDE, 0x00]
        let str = ISO_32000.COS.StringValue(pdfStringBytes: bytes)
        #expect(str.value == "\u{1F600}")
    }

    @Test
    func `pdfStringBytes reassembles a surrogate pair inside a mixed payload`() {
        // BOM + 'A' (0041) + high/low surrogate (D83D DE00) + 'B' (0042).
        let bytes: [Byte] = [
            0xFE, 0xFF,
            0x00, 0x41,
            0xD8, 0x3D, 0xDE, 0x00,
            0x00, 0x42,
        ]
        let str = ISO_32000.COS.StringValue(pdfStringBytes: bytes)
        #expect(str.value == "A\u{1F600}B")
    }
}

extension ISO_32000.COS.StringValue.Tests.Integration {
    // Round-trip: encode an astral-plane payload with `asHexadecimal()`,
    // strip the `<...>` delimiters, decode the hex back to raw bytes, and
    // parse those bytes with `pdfStringBytes(_:)`. Pre-fix this either
    // trapped at the encode step or produced a string with the astral-plane
    // scalar silently missing at the decode step; post-fix it round-trips.
    @Test(
        arguments: [
            "\u{1F600}",  // GRINNING FACE alone
            "A\u{1F600}B",  // astral scalar surrounded by BMP characters
            "\u{1F600}\u{1F601}",  // two adjacent astral-plane scalars
        ]
    )
    func `hex encode then pdfStringBytes decode round-trips an astral-plane payload`(_ original: String) {
        let str = ISO_32000.COS.StringValue(original)
        let hexString = String(decoding: str.asHexadecimal(), as: UTF8.self)

        // Strip the leading '<' and trailing '>' delimiters before decoding.
        let innerHex = hexString.dropFirst().dropLast()
        let rawBytes = RFC_4648.Base16.decode(innerHex, skipPrefix: false)!

        let roundTripped = ISO_32000.COS.StringValue(pdfStringBytes: rawBytes)
        #expect(roundTripped.value == original)
    }
}
