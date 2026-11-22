public import ISO_32000_Shared

extension ISO.`32000`.`3` {

    public struct `Binary data`<Source>
    where Source: Swift::Collection, Source.Element == ISO.`32000`.`3`.Byte {
        public let source: Source
    }
}

extension ISO.`32000`.`3`.`Binary data`: ExpressibleByArrayLiteral
where Source == [ISO.`32000`.`3`.Byte] {
    public typealias ArrayLiteralElement = ISO.`32000`.`3`.Byte

    public init(arrayLiteral elements: ISO.`32000`.`3`.Byte...) {
        self.source = elements
    }
}
