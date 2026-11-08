public import Byte
public import ISO_32000_Shared


extension ISO_32000 {
    @frozen
    public struct GlyphName: Hashable, Sendable {

        public let bytes: [Byte]

        @inlinable
        public init(bytes: [Byte]) {
            self.bytes = bytes
        }

        @inlinable
        public init(_ name: StaticString) {
            self.bytes = name.withUTF8Buffer { unsafe $0.map(Byte.init(bitPattern:)) }
        }
    }
}
