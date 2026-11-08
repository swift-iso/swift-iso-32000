public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureDictionary {
    public enum CertValue: Sendable, Hashable {

        case single([Byte])

        case chain([[Byte]])
    }
}
