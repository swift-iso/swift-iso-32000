public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Transition.TransitionDict {
    public enum Style: String, Sendable, Hashable, Codable, CaseIterable {

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
