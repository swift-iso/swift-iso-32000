public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Button.IconFit {
    public enum ScaleMode: String, Sendable, Hashable, Codable, CaseIterable {

        case always = "A"

        case bigger = "B"

        case smaller = "S"

        case never = "N"
    }
}
