public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Thread {
    public enum BeadSpec: Sendable, Hashable {

        case index(Int)

        case reference(Int)
    }
}
