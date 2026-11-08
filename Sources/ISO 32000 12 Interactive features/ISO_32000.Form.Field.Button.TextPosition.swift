public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Button {
    public enum TextPosition: Int, Sendable, Hashable, Codable, CaseIterable {

        case captionOnly = 0

        case iconOnly = 1

        case captionBelowIcon = 2

        case captionAboveIcon = 3

        case captionRightOfIcon = 4

        case captionLeftOfIcon = 5

        case captionOverIcon = 6
    }
}
