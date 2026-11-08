public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Thread {
    public enum ThreadSpec: Sendable, Hashable {

        case index(Int)

        case title(String)

        case reference(Int)
    }
}
