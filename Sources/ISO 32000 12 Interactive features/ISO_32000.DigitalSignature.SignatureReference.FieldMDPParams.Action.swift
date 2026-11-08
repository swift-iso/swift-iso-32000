public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference.FieldMDPParams {
    public enum Action: String, Sendable, Hashable, Codable, CaseIterable {

        case all = "All"

        case include = "Include"

        case exclude = "Exclude"
    }
}
