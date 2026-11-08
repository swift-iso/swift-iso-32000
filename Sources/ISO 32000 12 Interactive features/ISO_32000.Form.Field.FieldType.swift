public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public enum FieldType: String, Sendable, Hashable, Codable, CaseIterable {

        case button = "Btn"

        case text = "Tx"

        case choice = "Ch"

        case signature = "Sig"
    }
}
