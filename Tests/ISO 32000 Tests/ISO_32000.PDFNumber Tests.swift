import Binary_Serializable_Primitives
import Format_Primitives_Standard_Library_Integration
import Testing

@testable import ISO_32000

extension ISO_32000.`7`.`3`.`3`.PDFNumber {
    @Suite struct Tests {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

extension ISO_32000.`7`.`3`.`3`.PDFNumber.Tests.Unit {
    @Test
    func `serializes a plain integer without a decimal point`() {
        #expect(String(42.0.pdf) == "42")
    }

    @Test
    func `serializes a simple real with trailing zeros stripped`() {
        #expect(String(72.5.pdf) == "72.5")
    }

    @Test
    func `serializes a negative real`() {
        #expect(String((-3.25).pdf) == "-3.25")
    }
}

extension ISO_32000.`7`.`3`.`3`.PDFNumber.Tests.`Edge Case` {

    @Test
    func `fractional rounding carries into the integer part (0-point-999995)`() {
        #expect(String(0.999995.pdf) == "1")
    }

    @Test
    func `fractional rounding carries into the integer part (1-point-999999)`() {
        #expect(String(1.999999.pdf) == "2")
    }

    @Test
    func `fractional rounding carries for negative values`() {
        #expect(String((-0.999995).pdf) == "-1")
    }

    @Test
    func `does not trap at positive 2 to the 63rd power`() {
        let boundary = 9_223_372_036_854_775_808.0
        #expect(String(boundary.pdf) == "9223372036854775808")
    }

    @Test
    func `does not trap at negative 2 to the 63rd power`() {
        let boundary = -9_223_372_036_854_775_808.0
        #expect(String(boundary.pdf) == "-9223372036854775808")
    }

    @Test
    func `clamps rather than traps for magnitudes beyond UInt64 max`() {
        #expect(String(Double.greatestFiniteMagnitude.pdf) == "18446744073709551615")
    }

    @Test
    func `subnormal magnitudes round to zero without a bare negative sign`() {
        #expect(String(Double.leastNonzeroMagnitude.pdf) == "0")
        #expect(String((-Double.leastNonzeroMagnitude).pdf) == "0")
    }

    @Test
    func `non finite values serialize as zero`() {
        #expect(String(Double.nan.pdf) == "0")
        #expect(String(Double.infinity.pdf) == "0")
        #expect(String((-Double.infinity).pdf) == "0")
    }
}

extension ISO_32000.`7`.`3`.`3`.PDFNumber.Tests.Integration {

    @Test(
        arguments: [
            0.0, 42.0, 72.5, -3.25,
            0.999995, 1.999999, -0.999995,
            3.14159265,
            9_223_372_036_854_775_808.0, -9_223_372_036_854_775_808.0,
            Double.greatestFiniteMagnitude,
            Double.leastNonzeroMagnitude, -Double.leastNonzeroMagnitude,
            Double.nan, Double.infinity, -Double.infinity,
        ]
    )
    func `String and byte serialization paths agree`(_ value: Double) {
        let bytePath = String(decoding: value.pdf.bytes, as: UTF8.self)
        let stringPath = value.formatted(.pdf)
        #expect(bytePath == stringPath)
    }

    @Test
    func `COS serialize real case matches the canonical byte serializer`() {
        var cosBuffer: [Byte] = []
        ISO_32000.COS.serialize(.real(0.999995), into: &cosBuffer)

        #expect(cosBuffer == 0.999995.pdf.bytes)
    }
}
