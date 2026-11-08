public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Transition {
    public enum Style: String, Sendable, Codable, CaseIterable {

        case split = "Split"

        case blinds = "Blinds"

        case box = "Box"

        case wipe = "Wipe"

        case dissolve = "Dissolve"

        case glitter = "Glitter"

        case replace = "R"

        case fly = "Fly"

        case push = "Push"

        case cover = "Cover"

        case uncover = "Uncover"

        case fade = "Fade"
    }
}
