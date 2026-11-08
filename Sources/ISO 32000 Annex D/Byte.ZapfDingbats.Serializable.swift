public import Byte
public import ISO_32000_Shared


extension Byte.ZapfDingbats {
    public protocol Serializable: Sendable {
        associatedtype Error: Swift::Error
        associatedtype Context: Sendable = Void

        init<Bytes: Swift::Collection>(
            zapfDingbats bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            zapfDingbats serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }
}
