public import Dimension_Primitives
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`9` {

    public enum `3` {}
}

extension ISO_32000.Text {

    public struct State: Sendable, Equatable, Hashable {

        public var characterSpacing: ISO_32000.TextSpace.Dx

        public var wordSpacing: ISO_32000.TextSpace.Dx

        public var horizontalScaling: Scale<1, Double>

        public var leading: ISO_32000.TextSpace.Dy

        public var font: Font.Reference?

        public var fontSize: ISO_32000.UserSpace.Size<1>?

        public var renderingMode: Rendering.Mode

        public var rise: ISO_32000.TextSpace.Dy

        public var knockout: Bool

        public init(
            characterSpacing: ISO_32000.TextSpace.Dx = .init(0),
            wordSpacing: ISO_32000.TextSpace.Dx = .init(0),
            horizontalScaling: Scale<1, Double> = 100,
            leading: ISO_32000.TextSpace.Dy = .init(0),
            font: Font.Reference? = nil,
            fontSize: ISO_32000.UserSpace.Size<1>? = nil,
            renderingMode: Rendering.Mode = .fill,
            rise: ISO_32000.TextSpace.Dy = .init(0),
            knockout: Bool = true
        ) {
            self.characterSpacing = characterSpacing
            self.wordSpacing = wordSpacing
            self.horizontalScaling = horizontalScaling
            self.leading = leading
            self.font = font
            self.fontSize = fontSize
            self.renderingMode = renderingMode
            self.rise = rise
            self.knockout = knockout
        }
    }
}

#if !hasFeature(Embedded)
    extension ISO_32000.Text.State: Codable {}
#endif

extension ISO_32000.Text {

    public enum Font {}
}

extension ISO_32000.Text.Font {

    public struct Reference: Sendable, Equatable, Hashable {

        public var name: String

        public init(name: String) {
            self.name = name
        }
    }
}

#if !hasFeature(Embedded)
    extension ISO_32000.Text.Font.Reference: Codable {}
#endif

extension ISO_32000.Text {

    public enum Rendering {}
}

extension ISO_32000.Text.Rendering {

    public enum Mode: Int, Sendable, Equatable, Hashable, Codable, CaseIterable {

        case fill = 0

        case stroke = 1

        case fillStroke = 2

        case invisible = 3

        case fillClip = 4

        case strokeClip = 5

        case fillStrokeClip = 6

        case clip = 7
    }
}

extension ISO_32000.Text.Rendering.Mode {

    public var fills: Bool {
        switch self {
        case .fill, .fillStroke, .fillClip, .fillStrokeClip:
            true

        case .stroke, .invisible, .strokeClip, .clip:
            false
        }
    }

    public var strokes: Bool {
        switch self {
        case .stroke, .fillStroke, .strokeClip, .fillStrokeClip:
            true

        case .fill, .invisible, .fillClip, .clip:
            false
        }
    }

    public var clips: Bool {
        switch self {
        case .fillClip, .strokeClip, .fillStrokeClip, .clip:
            true

        case .fill, .stroke, .fillStroke, .invisible:
            false
        }
    }

    public var isVisible: Bool {
        self != .invisible && self != .clip
    }
}

extension ISO_32000.`9`.`3` {

    public typealias State = ISO_32000.Text.State

    public typealias RenderingMode = ISO_32000.Text.Rendering.Mode
}
