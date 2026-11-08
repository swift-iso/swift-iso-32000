public import Byte
public import ISO_32000_Shared


extension Byte {
    @frozen
    public struct Standard: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }
}
