public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Signature.Lock {
    public enum Action: String, Sendable, Hashable, Codable, CaseIterable {

        case all = "All"

        case include = "Include"

        case exclude = "Exclude"
    }
}
