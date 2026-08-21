public import Geometry_Primitives
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `4` {}
}

extension ISO_32000 {

    public enum PageLabel {}
}

extension ISO_32000.PageLabel {

    public struct Entry: Sendable, Equatable, Hashable, Codable {

        public var style: Style?

        public var prefix: String?

        public var start: Int

        public init(
            style: Style? = nil,
            prefix: String? = nil,
            start: Int = 1
        ) {
            self.style = style
            self.prefix = prefix
            self.start = start
        }
    }
}

extension ISO_32000.PageLabel.Entry {

    public enum Style: String, Sendable, Codable, CaseIterable {

        case decimal = "D"

        case romanUpper = "R"

        case romanLower = "r"

        case letterUpper = "A"

        case letterLower = "a"
    }
}

extension ISO_32000 {

    public enum Article {}
}

extension ISO_32000.Article {

    public struct Thread: Sendable {

        public var beads: [Bead]

        public var info: Info?

        public init(beads: [Bead] = [], info: Info? = nil) {
            self.beads = beads
            self.info = info
        }
    }
}

extension ISO_32000.Article {

    public struct Info: Sendable, Equatable, Hashable, Codable {

        public var title: String?

        public var author: String?

        public var subject: String?

        public var keywords: String?

        public init(
            title: String? = nil,
            author: String? = nil,
            subject: String? = nil,
            keywords: String? = nil
        ) {
            self.title = title
            self.author = author
            self.subject = subject
            self.keywords = keywords
        }
    }
}

extension ISO_32000.Article {

    public struct Bead: Sendable {

        public var pageIndex: Int

        public var rect: ISO_32000.UserSpace.Rectangle

        public init(pageIndex: Int, rect: ISO_32000.UserSpace.Rectangle) {
            self.pageIndex = pageIndex
            self.rect = rect
        }
    }
}

extension ISO_32000 {

    public enum Transition {}
}

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

extension ISO_32000.Transition {

    public enum Dimension: String, Sendable, Codable {

        case horizontal = "H"

        case vertical = "V"
    }
}

extension ISO_32000.Transition {

    public enum Motion: String, Sendable, Codable {

        case inward = "I"

        case outward = "O"
    }
}

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

extension ISO_32000.Transition.Direction {

    public var degrees: Int? {
        switch self {
        case .leftToRight: return 0
        case .bottomToTop: return 90
        case .rightToLeft: return 180
        case .topToBottom: return 270
        case .diagonal: return 315
        case .none: return nil
        }
    }
}

extension ISO_32000.Transition {

    public struct Effect: Sendable {

        public var style: Style

        public var duration: Double

        public var dimension: Dimension?

        public var motion: Motion?

        public var direction: Direction?

        public var scale: Double?

        public var opaque: Bool?

        public init(
            style: Style = .replace,
            duration: Double = 1.0,
            dimension: Dimension? = nil,
            motion: Motion? = nil,
            direction: Direction? = nil,
            scale: Double? = nil,
            opaque: Bool? = nil
        ) {
            self.style = style
            self.duration = duration
            self.dimension = dimension
            self.motion = motion
            self.direction = direction
            self.scale = scale
            self.opaque = opaque
        }
    }
}

extension ISO_32000 {

    public enum Navigation {}
}

extension ISO_32000.Navigation {

    public struct Node: Sendable {

        public var nextAction: ISO_32000.Action.GoTo?

        public var previousAction: ISO_32000.Action.GoTo?

        public var duration: Double?

        public init(
            nextAction: ISO_32000.Action.GoTo? = nil,
            previousAction: ISO_32000.Action.GoTo? = nil,
            duration: Double? = nil
        ) {
            self.nextAction = nextAction
            self.previousAction = previousAction
            self.duration = duration
        }
    }
}

extension ISO_32000.`12`.`4` {

    public typealias Label = ISO_32000.PageLabel.Entry

    public typealias Thread = ISO_32000.Article.Thread

    public typealias Bead = ISO_32000.Article.Bead

    public typealias TransitionStyle = ISO_32000.Transition.Style

    public typealias TransitionEffect = ISO_32000.Transition.Effect

    public typealias NavigationNode = ISO_32000.Navigation.Node
}
