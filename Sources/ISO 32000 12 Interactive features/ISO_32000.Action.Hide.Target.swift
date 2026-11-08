public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Hide {
    public enum Target: Sendable, Equatable, Hashable, Codable {

        case annotation(Int)

        case field(String)

        case multiple([Target])
    }
}
