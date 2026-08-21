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

        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<4869>")
    }
}

extension ISO_32000.COS.StringValue.Tests.`Edge Case` {

    @Test
    func `asHexadecimal does not trap on an astral-plane scalar`() {

        let str = ISO_32000.COS.StringValue("\u{1F600}")
        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<FEFFD83DDE00>")
    }

    @Test
    func `asHexadecimal does not trap on a mixed BMP and astral-plane payload`() {
        let str = ISO_32000.COS.StringValue("A\u{1F600}B")

        #expect(String(decoding: str.asHexadecimal(), as: UTF8.self) == "<FEFF0041D83DDE000042>")
    }

    @Test
    func `pdfStringBytes reassembles a surrogate pair into its astral-plane scalar`() {

        let bytes: [Byte] = [0xFE, 0xFF, 0xD8, 0x3D, 0xDE, 0x00]
        let str = ISO_32000.COS.StringValue(pdfStringBytes: bytes)
        #expect(str.value == "\u{1F600}")
    }

    @Test
    func `pdfStringBytes reassembles a surrogate pair inside a mixed payload`() {

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

    @Test(
        arguments: [
            "\u{1F600}",
            "A\u{1F600}B",
            "\u{1F600}\u{1F601}",
        ]
    )
    func `hex encode then pdfStringBytes decode round-trips an astral-plane payload`(
        _ original: String
    ) {
        let str = ISO_32000.COS.StringValue(original)
        let hexString = String(decoding: str.asHexadecimal(), as: UTF8.self)

        let innerHex = hexString.dropFirst().dropLast()
        let rawBytes = RFC_4648.Base16.decode(innerHex, skipPrefix: false)!

        let roundTripped = ISO_32000.COS.StringValue(pdfStringBytes: rawBytes)
        #expect(roundTripped.value == original)
    }
}
