public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public enum FieldValue: Sendable, Hashable {

        case text(String)

        case name(String)

        case array([String])

        case stream(Int)
    }
}
