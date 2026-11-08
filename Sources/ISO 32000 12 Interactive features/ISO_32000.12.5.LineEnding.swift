public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5` {
    public enum LineEnding: String, Sendable, Hashable, Codable, CaseIterable {

        case square = "Square"

        case circle = "Circle"

        case diamond = "Diamond"

        case openArrow = "OpenArrow"

        case closedArrow = "ClosedArrow"

        case none = "None"

        case butt = "Butt"

        case rOpenArrow = "ROpenArrow"

        case rClosedArrow = "RClosedArrow"

        case slash = "Slash"
    }
}
