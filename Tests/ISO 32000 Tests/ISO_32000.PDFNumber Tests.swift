// ISO_32000.PDFNumber Tests.swift
//
// Fable-448 F-002 regression coverage: the real-number formatters in
// "ISO 32000 7 Syntax/7.3 Objects.swift" (`RealFormatStyle`, `PDFNumber`,
// and `COS.serialize`'s `.real` case) used to carry two independently-coded
// copies of the same integer/fraction-split logic, sharing a fractional
// rounding-carry defect and an `Int64` overflow trap. All three surfaces now
// delegate to one canonical byte-domain serializer.

import Testing
import Binary_Serializable_Primitives
import Format_Primitives_Standard_Library_Integration

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
    // F-002, defect 1: fractional rounding-carry. Rounding the fractional
    // remainder to 5 decimal places can itself reach the next whole unit
    // (e.g. 0.999995 -> fracDigits == 10^5); the historical bug emitted that
    // as an invalid 6-digit fraction instead of carrying into the integer
    // part.
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

    // F-002, defect 2: Int64 overflow trap. `Double(Int64.max)` rounds up to
    // exactly 2^63 (`Int64.max` itself is not exactly representable as a
    // `Double`), so any finite value at or beyond that magnitude used to be
    // handed straight to `Int64(_:)`, which traps for out-of-range
    // conversions. This implementation converts through `UInt64` instead
    // (doubling the safe ceiling to 2^64) and explicitly clamps beyond that.
    @Test
    func `does not trap at positive 2 to the 63rd power`() {
        let boundary = 9_223_372_036_854_775_808.0  // 2^63, == Double(Int64.max)
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
    // Proposed end state: "a property test asserting the String and byte
    // paths agree" — `RealFormatStyle` (String) and `PDFNumber` (bytes) must
    // produce identical digits for the same input now that both delegate to
    // the same canonical serializer.
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

    // `COS.serialize`'s `.real` case now calls the canonical serializer
    // directly rather than round-tripping through `RealFormatStyle`.
    @Test
    func `COS serialize real case matches the canonical byte serializer`() {
        var cosBuffer: [Byte] = []
        ISO_32000.COS.serialize(.real(0.999995), into: &cosBuffer)

        #expect(cosBuffer == 0.999995.pdf.bytes)
    }
}
