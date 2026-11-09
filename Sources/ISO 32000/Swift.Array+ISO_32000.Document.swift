public import Byte

extension Swift.Array where Element == Byte {

    /// The bytes of `document` as a PDF file, written by `ISO_32000.Writer`.
    public init(_ document: ISO_32000.Document) throws(ISO_32000.Writer.Error) {
        var writer = ISO_32000.Writer()
        self = try writer.write(document)
    }
}
