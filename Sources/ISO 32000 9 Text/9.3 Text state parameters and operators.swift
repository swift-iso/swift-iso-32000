import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import Space

extension ISO_32000.`9` {

    public enum `3` {}
}

extension ISO_32000.Text {
}

#if !hasFeature(Embedded)
    extension ISO_32000.Text.State: Codable {}
#endif

extension ISO_32000.Text {
}

extension ISO_32000.Text.Font {
}

#if !hasFeature(Embedded)
    extension ISO_32000.Text.Font.Reference: Codable {}
#endif

extension ISO_32000.Text {
}

extension ISO_32000.Text.Rendering {
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
