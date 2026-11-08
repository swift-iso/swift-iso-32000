public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference {
    public enum TransformParams: Sendable, Hashable {
        case docMDP(DocMDPParams)
        case ur(URParams)
        case fieldMDP(FieldMDPParams)
    }
}
