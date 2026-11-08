public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Launch.WindowsLaunch {
    public enum Operation: String, Sendable, Hashable, Codable, CaseIterable {

        case open

        case print
    }
}
