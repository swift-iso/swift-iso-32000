public import ISO_32000_Shared

extension ISO_32000.`3` {

    public struct `Binary data`<Source>
    where Source: Collection, Source.Element == ISO_32000.`3`.Byte {
        public let source: Source
    }
}

extension ISO_32000.`3`.`Binary data`: ExpressibleByArrayLiteral
where Source == [ISO_32000.`3`.Byte] {
    public typealias ArrayLiteralElement = ISO_32000.`3`.Byte

    public init(arrayLiteral elements: ISO_32000.`3`.Byte...) {
        self.source = elements
    }
}
