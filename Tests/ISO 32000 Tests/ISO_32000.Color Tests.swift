import Testing

@testable import ISO_32000

@Suite
struct `ISO_32000.Color Tests` {

    @Test
    func `three hex digits expand each nibble`() {
        #expect(ISO_32000.Color(hex: "#F00") == .rgb(r: 1, g: 0, b: 0))
    }

    @Test
    func `six hex digits read each byte`() {
        #expect(ISO_32000.Color(hex: "00FF00") == .rgb(r: 0, g: 1, b: 0))
    }

    @Test(arguments: ["", "#", "12", "1234", "12345", "1234567", "#12345678901234567890", "GGG"])
    func `other lengths and non-hex digits are rejected`(_ hex: String) {
        #expect(ISO_32000.Color(hex: hex) == nil)
    }
}
