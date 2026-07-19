// ISO 32000-2:2020, 9.3 Text state parameters and operators
//
// Sections:
//   9.3.1  General
//   9.3.2  Character spacing
//   9.3.3  Word spacing
//   9.3.4  Horizontal scaling
//   9.3.5  Leading
//   9.3.6  Text rendering mode
//   9.3.7  Text rise
//   9.3.8  Text knockout

public import Dimension_Primitives
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`9` {
    /// ISO 32000-2:2020, 9.3 Text state parameters and operators
    public enum `3` {}
}

// MARK: - 9.3.1 Text State

extension ISO_32000.Text {
    /// Text state parameters (Table 102)
    ///
    /// The text state comprises those graphics state parameters that only affect text.
    /// These parameters are consulted when text is positioned and shown.
    ///
    /// Per ISO 32000-2:2020, Section 9.3.1:
    /// > The text state operators may appear outside text objects, and the values
    /// > they set are retained across text objects in a single content stream.
    /// > Like other graphics state parameters, these parameters shall be initialised
    /// > to their default values at the beginning of each page.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 102 — Text state parameters
    public struct State: Sendable, Equatable, Hashable {
        /// Character spacing (Tc)
        ///
        /// Added to the horizontal or vertical displacement of each glyph.
        /// Expressed in unscaled text space units.
        ///
        /// Initial value: 0
        public var characterSpacing: ISO_32000.TextSpace.Dx

        /// Word spacing (Tw)
        ///
        /// Applied only to ASCII SPACE (0x20).
        /// Expressed in unscaled text space units.
        ///
        /// Initial value: 0
        public var wordSpacing: ISO_32000.TextSpace.Dx

        /// Horizontal scaling (Th)
        ///
        /// Percentage of normal width (100 = normal).
        /// Affects glyph shape and horizontal displacement.
        ///
        /// Initial value: 100
        public var horizontalScaling: Scale<1, Double>

        /// Leading (Tl)
        ///
        /// Vertical distance between baselines of adjacent lines.
        /// Expressed in unscaled text space units.
        /// Used by T*, ', and " operators.
        ///
        /// Initial value: 0
        public var leading: ISO_32000.TextSpace.Dy

        /// Text font reference (Tf)
        ///
        /// Reference to the font resource. Must be set before showing text.
        ///
        /// Initial value: none (must be set explicitly)
        public var font: Font.Reference?

        /// Text font size (Tfs)
        ///
        /// Scale factor for the font, in user space units (points).
        /// This determines the scaling from text space to user space.
        /// Note: Negative font size is permitted per spec.
        ///
        /// Initial value: none (must be set explicitly)
        public var fontSize: ISO_32000.UserSpace.Size<1>?

        /// Text rendering mode (Tmode)
        ///
        /// Determines whether text is filled, stroked, clipped, or invisible.
        ///
        /// Initial value: 0 (fill)
        public var renderingMode: Rendering.Mode

        /// Text rise (Trise)
        ///
        /// Distance to move baseline up (positive) or down (negative).
        /// Useful for superscripts and subscripts.
        /// Expressed in unscaled text space units.
        ///
        /// Initial value: 0
        public var rise: ISO_32000.TextSpace.Dy

        /// Text knockout (Tk)
        ///
        /// Determines compositing behavior for overlapping glyphs.
        /// Set via TK entry in graphics state parameter dictionary.
        ///
        /// Initial value: true
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

// MARK: - Font Reference

extension ISO_32000.Text {
    /// Font namespace
    public enum Font {}
}

extension ISO_32000.Text.Font {
    /// A reference to a font resource
    ///
    /// References a font by its resource name as used in the page's
    /// Font subdictionary.
    public struct Reference: Sendable, Equatable, Hashable {
        /// The font resource name (for example, "F1", "F2")
        public var name: String

        /// Create a font reference
        ///
        /// - Parameter name: The font resource name
        public init(name: String) {
            self.name = name
        }
    }
}

#if !hasFeature(Embedded)
    extension ISO_32000.Text.Font.Reference: Codable {}
#endif

// MARK: - 9.3.6 Text Rendering Mode

extension ISO_32000.Text {
    /// Rendering namespace
    public enum Rendering {}
}

extension ISO_32000.Text.Rendering {
    /// Text rendering modes (Table 104)
    ///
    /// Determines whether showing text causes glyph outlines to be
    /// stroked, filled, used as a clipping boundary, or some combination.
    ///
    /// Per ISO 32000-2:2020, Section 9.3.6:
    /// > If the text rendering mode calls for filling, the current nonstroking
    /// > colour in the graphics state shall be used; if it calls for stroking,
    /// > the current stroking colour shall be used.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 104 — Text rendering modes
    public enum Mode: Int, Sendable, Equatable, Hashable, Codable, CaseIterable {
        /// Fill text (mode 0)
        case fill = 0

        /// Stroke text (mode 1)
        case stroke = 1

        /// Fill, then stroke text (mode 2)
        case fillStroke = 2

        /// Neither fill nor stroke text — invisible (mode 3)
        case invisible = 3

        /// Fill text and add to path for clipping (mode 4)
        case fillClip = 4

        /// Stroke text and add to path for clipping (mode 5)
        case strokeClip = 5

        /// Fill, then stroke text and add to path for clipping (mode 6)
        case fillStrokeClip = 6

        /// Add text to path for clipping (mode 7)
        case clip = 7
    }
}

extension ISO_32000.Text.Rendering.Mode {
    /// Whether this mode fills the glyph outlines
    public var fills: Bool {
        switch self {
        case .fill, .fillStroke, .fillClip, .fillStrokeClip:
            true
        case .stroke, .invisible, .strokeClip, .clip:
            false
        }
    }

    /// Whether this mode strokes the glyph outlines
    public var strokes: Bool {
        switch self {
        case .stroke, .fillStroke, .strokeClip, .fillStrokeClip:
            true
        case .fill, .invisible, .fillClip, .clip:
            false
        }
    }

    /// Whether this mode adds to the clipping path
    public var clips: Bool {
        switch self {
        case .fillClip, .strokeClip, .fillStrokeClip, .clip:
            true
        case .fill, .stroke, .fillStroke, .invisible:
            false
        }
    }

    /// Whether this mode renders anything visible
    public var isVisible: Bool {
        self != .invisible && self != .clip
    }
}

// MARK: - Section Typealiases

extension ISO_32000.`9`.`3` {
    /// Text state parameters (Table 102)
    public typealias State = ISO_32000.Text.State

    /// Text rendering mode (Table 104)
    public typealias RenderingMode = ISO_32000.Text.Rendering.Mode
}
