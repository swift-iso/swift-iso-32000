public import Byte
public import ISO_32000_Shared


extension Byte.PDFDoc {
    public protocol Serializable: Sendable {
        associatedtype Error: Swift::Error
        associatedtype Context: Sendable = Void

        init<Bytes: Swift::Collection>(
            pdfDoc bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            pdfDoc serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }
}
