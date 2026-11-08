public import Byte
public import ISO_32000_Shared


extension Byte {
    @frozen
    public struct MacRoman: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }
}
