public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000 {

    @frozen
    public struct WinAnsi<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.WinAnsi {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.WinAnsiEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var winAnsi: ISO_32000.WinAnsi<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct PDFDoc<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.PDFDoc {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.PDFDocEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var pdfDoc: ISO_32000.PDFDoc<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct Standard<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.Standard {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.StandardEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var standard: ISO_32000.Standard<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct MacRoman<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.MacRoman {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.MacRomanEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var macRoman: ISO_32000.MacRoman<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct MacExpert<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.MacExpert {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.MacExpertEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var macExpert: ISO_32000.MacExpert<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct Symbol<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.Symbol {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.SymbolEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var symbol: ISO_32000.Symbol<Self> { .init(self) }
}

extension ISO_32000 {

    @frozen
    public struct ZapfDingbats<Source: Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO_32000.ZapfDingbats {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO_32000.ZapfDingbatsEncoding.decode($0) != nil }
    }
}

extension Collection where Element == Byte {

    @inlinable
    public var zapfDingbats: ISO_32000.ZapfDingbats<Self> { .init(self) }
}
