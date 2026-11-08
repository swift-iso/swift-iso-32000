public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.GoToE.Target {
    public enum Relation: String, Sendable, Hashable, Codable, CaseIterable {

        case parent = "P"

        case child = "C"
    }
}
