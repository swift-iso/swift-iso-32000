public import ASCII_Primitives
import Binary_Endianness_Primitives
import Binary_Primitives_Standard_Library_Integration
import Binary_Serializable_Primitives
import Byte_Primitives
import Byte_Primitives_Standard_Library_Integration
import ISO_32000_7_Syntax
import ISO_32000_Annex_D

extension ISO_32000.COS.StringValue {

    public var canUsePDFDocEncoding: Bool {
        value.unicodeScalars.allSatisfy { ISO_32000.PDFDocEncoding.canEncode($0) }
    }
}

extension ISO_32000.COS.StringValue {

    public func asLiteral() -> [Byte] {
        var result: [Byte] = [.ascii.leftParenthesis]

        if canUsePDFDocEncoding {

            for scalar in value.unicodeScalars {
                if let byte = ISO_32000.PDFDocEncoding.encode(scalar) {
                    if let escaped = ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] {
                        result.append(contentsOf: escaped)
                    } else {
                        result.append(byte)
                    }
                }
            }
        } else {

            result.append(0xFE)
            result.append(0xFF)
            for codeUnit in value.utf16 {

                for byte in codeUnit.bytes(endianness: .big) {

                    if let escaped = ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] {
                        result.append(contentsOf: escaped)
                    } else {
                        result.append(byte)
                    }
                }
            }
        }

        result.append(.ascii.rightParenthesis)
        return result
    }

    public func asLiteralWinAnsi() -> [Byte] {

        let encodedBytes = [Byte](winAnsi: value, withFallback: true)

        return ISO_32000.`7`.`3`.Table.`3`.literalString(from: encodedBytes)
    }

    public func asHexadecimal() -> [Byte] {
        var result: [Byte] = [.ascii.lessThan]

        if canUsePDFDocEncoding {

            for scalar in value.unicodeScalars {
                if let byte = ISO_32000.PDFDocEncoding.encode(scalar) {

                    result.append(Self.hexChar(byte.underlying >> 4))
                    result.append(Self.hexChar(byte.underlying & 0x0F))
                }
            }
        } else {

            result.append(.ascii.F)
            result.append(.ascii.E)
            result.append(.ascii.F)
            result.append(.ascii.F)

            for codeUnit in value.utf16 {
                for byte in codeUnit.bytes(endianness: .big) {
                    result.append(Self.hexChar(byte.underlying >> 4))
                    result.append(Self.hexChar(byte.underlying & 0x0F))
                }
            }
        }

        result.append(.ascii.greaterThan)
        return result
    }

    private static func hexChar(_ nibble: UInt8) -> ASCII.Code {
        ASCII.Hexadecimal.code(nibble, case: .upper) ?? 0x30
    }

    public enum Format: Sendable {
        case literal
        case hexadecimal
    }

    public var preferredFormat: Format {

        guard canUsePDFDocEncoding else {
            return .hexadecimal
        }

        var escapeCount = 0
        for scalar in value.unicodeScalars {
            if let byte = ISO_32000.PDFDocEncoding.encode(scalar),
                ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] != nil
            {
                escapeCount += 1
            }
        }

        let total = value.unicodeScalars.count
        if total > 0 && Double(escapeCount) / Double(total) > 0.25 {
            return .hexadecimal
        }
        return .literal
    }
}

extension ISO_32000.COS.StringValue {

    public init<C: Collection>(pdfStringBytes bytes: C) where C.Element == Byte {
        switch ISO_32000.PDFDocEncoding.detectEncoding(bytes) {
        case .pdfDocEncoding:
            self.init(String(pdfDoc: [Byte](bytes), withReplacement: true))

        case .utf16BE:

            let dataBytes = bytes.dropFirst(2)
            var codeUnits: [UInt16] = []
            var iterator = dataBytes.makeIterator()
            while let hi = iterator.next(), let lo = iterator.next() {
                codeUnits.append(UInt16(bytes: [hi, lo], endianness: .big)!)
            }
            self.init(String(decoding: codeUnits, as: UTF16.self))

        case .utf8:

            let dataBytes = Array(bytes.dropFirst(3))
            self.init(String(decoding: dataBytes, as: UTF8.self))
        }
    }
}
