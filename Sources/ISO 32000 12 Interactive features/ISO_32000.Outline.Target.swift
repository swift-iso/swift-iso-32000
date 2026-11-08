public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Outline {
    public enum Target: Sendable {

        case destination(ISO_32000.Destination)

        case action(ISO_32000.Action.Kind)
    }
}
