public import Byte

extension Swift.Array where Element == Byte {

    /// The bytes of `document` as a PDF file, written by `ISO_32000.Writer`.
    public init(_ document: ISO.`32000`.Document) throws(ISO.`32000`.Writer.Error) {
        var writer = ISO.`32000`.Writer()
        self = try writer.write(document)
    }
}
