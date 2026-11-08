public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Border.Style {
    public enum Kind: String, Sendable, Hashable, Codable, CaseIterable {

        case solid = "S"

        case dashed = "D"

        case beveled = "B"

        case inset = "I"

        case underline = "U"
    }
}
