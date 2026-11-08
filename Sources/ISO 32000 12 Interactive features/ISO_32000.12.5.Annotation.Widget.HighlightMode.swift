public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.`12`.`5`.Annotation.Widget {
    public enum HighlightMode: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "N"

        case invert = "I"

        case outline = "O"

        case push = "P"

        case toggle = "T"
    }
}
