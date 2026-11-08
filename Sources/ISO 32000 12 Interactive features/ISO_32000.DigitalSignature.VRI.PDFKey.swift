public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.VRI {
    public enum PDFKey: String, CodingKey {
        case cert = "Cert"
        case crl = "CRL"
        case ocsp = "OCSP"
        case createdTime = "TU"
        case timestamp = "TS"
    }
}
