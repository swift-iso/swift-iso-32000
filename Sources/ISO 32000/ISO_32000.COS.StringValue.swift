// ISO_32000.COS.StringValue.swift
// StringValue base is defined in Section 7.3.
// This file adds encoding-aware extensions using Annex D.

public import ASCII_Primitives
import Binary_Endianness_Primitives
import Binary_Primitives_Standard_Library_Integration
import Binary_Serializable_Primitives
public import Byte_Primitives
import Byte_Primitives_Standard_Library_Integration
import ISO_32000_7_Syntax
import ISO_32000_Annex_D

// MARK: - PDFDocEncoding Support (Annex D)

extension ISO_32000.COS.StringValue {
    /// Check if this string can be encoded in PDFDocEncoding
    ///
    /// Per ISO 32000-2 Section 7.9.2.2, if all characters are encodable
    /// in PDFDocEncoding, that encoding should be used. Otherwise,
    /// UTF-16BE with BOM is required.
    public var canUsePDFDocEncoding: Bool {
        value.unicodeScalars.allSatisfy { ISO_32000.PDFDocEncoding.canEncode($0) }
    }
}

extension ISO_32000.COS.StringValue {
    /// Serialize as literal string: `(Hello)`
    ///
    /// Uses PDFDocEncoding if all characters are encodable, otherwise
    /// falls back to UTF-16BE with BOM per ISO 32000-2 Section 7.9.2.2.
    /// `.utf16` iteration emits surrogate pairs for scalars beyond U+FFFF.
    ///
    /// TODO: dedup with StringValue.serialize(_:into:) at ISO 32000 7 Syntax/7.3 Objects.swift —
    /// both now carry the §7.9.2.2 algorithm; dedup pending separate dispatch.
    public func asLiteral() -> [Byte] {
        var result: [Byte] = [.ascii.leftParenthesis]

        if canUsePDFDocEncoding {
            // Use PDFDocEncoding - encode each scalar to its PDFDoc byte
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
            // UTF-16BE with BOM (0xFE 0xFF)
            result.append(0xFE)
            result.append(0xFF)
            for codeUnit in value.utf16 {
                // Serialize each UTF-16BE code unit as two big-endian bytes.
                for byte in codeUnit.bytes(endianness: .big) {
                    // Escape special bytes
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

    /// Serialize as literal string using WinAnsiEncoding: `(Hello)`
    ///
    /// For use in content streams with Standard 14 fonts, which use
    /// WinAnsiEncoding rather than PDFDocEncoding.
    ///
    /// Characters not in WinAnsiEncoding are replaced with `?`.
    public func asLiteralWinAnsi() -> [Byte] {
        // Encode string to WinAnsi bytes using Annex D — the array init vends
        // byte-domain `[Byte]` directly for the literal-string serializer.
        let encodedBytes = [Byte](winAnsi: value, withFallback: true)
        // Serialize as PDF literal string using 7.3 canonical function
        return ISO_32000.`7`.`3`.Table.`3`.literalString(from: encodedBytes)
    }

    /// Serialize as hexadecimal string: `<48656C6C6F>`
    ///
    /// Uses PDFDocEncoding if all characters are encodable, otherwise
    /// falls back to UTF-16BE with BOM per ISO 32000-2 Section 7.9.2.2.
    public func asHexadecimal() -> [Byte] {
        var result: [Byte] = [.ascii.lessThan]

        if canUsePDFDocEncoding {
            // Use PDFDocEncoding
            for scalar in value.unicodeScalars {
                if let byte = ISO_32000.PDFDocEncoding.encode(scalar) {
                    // Nibble extraction is arithmetic-domain; operate on the
                    // underlying UInt8, emit hex digits via the ecosystem primitive.
                    result.append(Self.hexChar(byte.underlying >> 4))
                    result.append(Self.hexChar(byte.underlying & 0x0F))
                }
            }
        } else {
            // UTF-16BE with BOM: FEFF
            result.append(.ascii.F)
            result.append(.ascii.E)
            result.append(.ascii.F)
            result.append(.ascii.F)

            // Iterate UTF-16 code units (not unicodeScalars), matching
            // asLiteral()'s UTF-16BE branch: any scalar beyond U+FFFF
            // (astral plane, e.g. emoji) is naturally split into its
            // surrogate pair this way. The old `UInt16(scalar.value)` narrowing
            // trapped (Fatal error: integer overflow) for every astral-plane
            // scalar, since `scalar.value` for those is > UInt16.max (F-003).
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

    /// Get the uppercase hex digit for a nibble (0–15).
    ///
    /// Adopts the ecosystem nibble→hex primitive
    /// (`ASCII.Hexadecimal.code(_:case:)`) rather than hand-rolling the
    /// `'0' + nibble` offset. A masked 0–15 nibble is always a valid hex digit,
    /// so the result is never nil.
    private static func hexChar(_ nibble: UInt8) -> ASCII.Code {
        ASCII.Hexadecimal.code(nibble, case: .upper) ?? 0x30
    }

    /// Preferred serialization format based on content
    public enum Format: Sendable {
        case literal
        case hexadecimal
    }

    /// Determine preferred format based on content
    ///
    /// Prefers literal strings unless many bytes need escaping.
    public var preferredFormat: Format {
        // If using UTF-16BE, hex is often cleaner
        guard canUsePDFDocEncoding else {
            return .hexadecimal
        }

        // Count bytes that need escaping in PDFDocEncoding
        var escapeCount = 0
        for scalar in value.unicodeScalars {
            if let byte = ISO_32000.PDFDocEncoding.encode(scalar),
                ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] != nil
            {
                escapeCount += 1
            }
        }

        // Use hex if more than 25% would need escaping
        let total = value.unicodeScalars.count
        if total > 0 && Double(escapeCount) / Double(total) > 0.25 {
            return .hexadecimal
        }
        return .literal
    }
}

// MARK: - Parsing

extension ISO_32000.COS.StringValue {
    /// Create a StringValue by parsing raw PDF string bytes
    ///
    /// Automatically detects encoding based on BOM:
    /// - Bytes starting with 0xFE 0xFF are UTF-16BE
    /// - Bytes starting with 0xEF 0xBB 0xBF are UTF-8
    /// - All other bytes are PDFDocEncoding
    ///
    /// - Parameter bytes: Raw bytes from a PDF string object (without delimiters)
    public init<C: Collection>(pdfStringBytes bytes: C) where C.Element == Byte {
        switch ISO_32000.PDFDocEncoding.detectEncoding(bytes) {
        case .pdfDocEncoding:
            self.init(String(pdfDoc: [Byte](bytes), withReplacement: true))
        case .utf16BE:
            // Skip BOM (first 2 bytes) and decode UTF-16BE.
            //
            // Collect the big-endian code units and decode the whole
            // sequence via `String(decoding:as: UTF16.self)`, which
            // correctly reassembles high/low surrogate pairs into their
            // astral-plane scalar. The old code resolved each code unit to
            // a `Unicode.Scalar` independently — `Unicode.Scalar(UInt16)`
            // returns nil for any value in the surrogate range
            // (0xD800...0xDFFF), which silently dropped *both* code units
            // of every surrogate pair instead of reconstructing the scalar
            // they encode (F-003).
            let dataBytes = bytes.dropFirst(2)
            var codeUnits: [UInt16] = []
            var iterator = dataBytes.makeIterator()
            while let hi = iterator.next(), let lo = iterator.next() {
                codeUnits.append(UInt16(bytes: [hi, lo], endianness: .big)!)
            }
            self.init(String(decoding: codeUnits, as: UTF16.self))
        case .utf8:
            // Skip BOM (first 3 bytes) and decode UTF-8
            let dataBytes = Array(bytes.dropFirst(3))
            self.init(String(decoding: dataBytes, as: UTF8.self))
        }
    }
}
