public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.SetOCGState {
    public enum Command: String, Sendable, Hashable, Codable, CaseIterable {

        case on = "ON"

        case off = "OFF"

        case toggle = "Toggle"
    }
}
