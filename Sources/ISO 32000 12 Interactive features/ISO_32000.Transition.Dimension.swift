public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Transition {
    public enum Dimension: String, Sendable, Codable {

        case horizontal = "H"

        case vertical = "V"
    }
}
