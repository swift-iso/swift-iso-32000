public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Transition {
    public enum Direction: Sendable, Equatable, Hashable, Codable {

        case leftToRight

        case bottomToTop

        case rightToLeft

        case topToBottom

        case diagonal

        case none
    }
}
