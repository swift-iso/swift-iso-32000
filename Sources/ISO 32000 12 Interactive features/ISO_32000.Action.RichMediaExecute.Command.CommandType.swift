public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.RichMediaExecute.Command {
    public enum CommandType: String, Sendable, Hashable, Codable, CaseIterable {

        case javaScript = "cycscript"
    }
}
