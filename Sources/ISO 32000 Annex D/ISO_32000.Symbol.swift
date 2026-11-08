public import Byte
public import ISO_32000_Shared


extension ISO_32000 {
    @frozen
    public struct Symbol<Source: Swift::Collection> where Source.Element == Byte {
        public let source: Source

        @inlinable
        public init(_ source: Source) {
            self.source = source
        }
    }
}
