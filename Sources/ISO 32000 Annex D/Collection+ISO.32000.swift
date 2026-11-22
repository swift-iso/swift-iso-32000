public import Byte
public import ISO_32000_Shared

extension ISO.`32000` {

    @frozen
    public struct WinAnsi<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.WinAnsi {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.WinAnsiEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var winAnsi: ISO.`32000`.WinAnsi<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct PDFDoc<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.PDFDoc {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.PDFDocEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var pdfDoc: ISO.`32000`.PDFDoc<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct Standard<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.Standard {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.StandardEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var standard: ISO.`32000`.Standard<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct MacRoman<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.MacRoman {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.MacRomanEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var macRoman: ISO.`32000`.MacRoman<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct MacExpert<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.MacExpert {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.MacExpertEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var macExpert: ISO.`32000`.MacExpert<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct Symbol<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.Symbol {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.SymbolEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var symbol: ISO.`32000`.Symbol<Self> { .init(self) }
}

extension ISO.`32000` {

    @frozen
    public struct ZapfDingbats<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}

extension ISO.`32000`.ZapfDingbats {

    @inlinable
    public var isValid: Bool {
        source.allSatisfy { ISO.`32000`.ZapfDingbatsEncoding.decode($0) != nil }
    }
}

extension Swift::Collection where Element == Byte {

    @inlinable
    public var zapfDingbats: ISO.`32000`.ZapfDingbats<Self> { .init(self) }
}
