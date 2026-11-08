public import Byte
public import ISO_32000_Shared


extension ISO_32000.PDFDocEncoding {
    public enum TextStringEncoding: Sendable {

        case pdfDocEncoding

        case utf16BE

        case utf8
    }
}
