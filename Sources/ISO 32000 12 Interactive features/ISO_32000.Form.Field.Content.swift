public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public enum Content: Sendable, Hashable {

        case button(Button)

        case text(Text)

        case choice(Choice)

        case signature(Signature)

        case container
    }
}
