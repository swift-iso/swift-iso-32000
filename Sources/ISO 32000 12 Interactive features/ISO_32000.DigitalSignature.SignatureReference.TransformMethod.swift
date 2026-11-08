public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference {
    public enum TransformMethod: String, Sendable, Hashable, Codable, CaseIterable {

        case docMDP = "DocMDP"

        case ur = "UR"

        case fieldMDP = "FieldMDP"
    }
}
