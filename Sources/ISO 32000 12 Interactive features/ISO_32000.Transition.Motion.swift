public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Transition {
    public enum Motion: String, Sendable, Codable {

        case inward = "I"

        case outward = "O"
    }
}
