// ISO 32000-2:2020, 9.4 Text objects
//
// Sections:
//   9.4.1  General
//   9.4.2  Text-positioning operators
//   9.4.3  Text-showing operators
//   9.4.4  Text space details

public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000.`9` {
    /// ISO 32000-2:2020, 9.4 Text objects
    public enum `4` {}
}

// MARK: - 9.4.4 Text Space

extension ISO_32000.`9`.`4` {
    /// 9.4.4 Text space details
    public enum `4` {}
}

extension ISO_32000.`9`.`4`.`4` {
    /// Text space marker (ISO 32000-2:2020, Section 9.4.4)
    ///
    /// Text space is the coordinate system in which text is shown. It is defined
    /// by the text matrix (Tm) and text state parameters (Tfs, Th, Trise).
    ///
    /// Text state parameters like character spacing (Tc), word spacing (Tw),
    /// leading (Tl), and text rise (Trise) are expressed in "unscaled text space
    /// units" - meaning they are in text space but not scaled by font size.
    ///
    /// Text space uses Double scalars for continuous positioning.
    public enum TextSpace {}
}

extension ISO_32000 {
    /// Text space (ISO 32000-2:2020, Section 9.4.4)
    ///
    /// The coordinate system in which text is shown, before transformation
    /// to user space via the text rendering matrix (Trm).
    ///
    /// Text state parameters are expressed in "unscaled text space units".
    public typealias TextSpace = Geometry<Double, ISO_32000.`9`.`4`.`4`.TextSpace>
}

// MARK: - 9.4.1 Text Matrix

extension ISO_32000.`9`.`4` {
    /// Text matrix (Tm) and text line matrix (Tlm)
    ///
    /// A 3×3 transformation matrix stored as 6 values (a, b, c, d, e, f).
    /// The third column is always [0, 0, 1].
    ///
    /// Per ISO 32000-2:2020, Section 9.4.1:
    /// > A text object begins with the BT operator and ends with the ET operator.
    /// > At the beginning of a text object, Tm shall be the identity matrix.
    ///
    /// The matrix represents:
    /// ```
    /// | a  b  0 |
    /// | c  d  0 |
    /// | e  f  1 |
    /// ```
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Section 9.4.2 — Text-positioning operators
    public struct Matrix: Sendable, Hashable {
        /// Horizontal scaling component
        public var a: Double

        /// Vertical shearing component
        public var b: Double

        /// Horizontal shearing component
        public var c: Double

        /// Vertical scaling component
        public var d: Double

        /// Horizontal translation (x position)
        public var e: Double

        /// Vertical translation (y position)
        public var f: Double

        /// Create a text matrix with explicit values
        ///
        /// - Parameters:
        ///   - a: Horizontal scaling (default 1)
        ///   - b: Vertical shearing (default 0)
        ///   - c: Horizontal shearing (default 0)
        ///   - d: Vertical scaling (default 1)
        ///   - e: Horizontal translation (default 0)
        ///   - f: Vertical translation (default 0)
        public init(
            a: Double = 1,
            b: Double = 0,
            c: Double = 0,
            d: Double = 1,
            e: Double = 0,
            f: Double = 0
        ) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
        }
    }
}

extension ISO_32000.`9`.`4`.Matrix {
    /// The identity matrix [1 0 0 1 0 0]
    public static let identity = Self()

    /// Create a translation matrix
    ///
    /// - Parameters:
    ///   - tx: Horizontal translation
    ///   - ty: Vertical translation
    /// - Returns: A translation matrix
    public static func translation(tx: Double, ty: Double) -> Self {
        Self(a: 1, b: 0, c: 0, d: 1, e: tx, f: ty)
    }

    /// Create a scaling matrix
    ///
    /// - Parameters:
    ///   - sx: Horizontal scale factor
    ///   - sy: Vertical scale factor
    /// - Returns: A scaling matrix
    public static func scaling(sx: Double, sy: Double) -> Self {
        Self(a: sx, b: 0, c: 0, d: sy, e: 0, f: 0)
    }

    /// Concatenate two matrices (lhs × rhs)
    ///
    /// - Parameters:
    ///   - lhs: Left matrix
    ///   - rhs: Right matrix
    /// - Returns: The resulting matrix
    public static func concatenating(_ lhs: Self, _ rhs: Self) -> Self {
        Self(
            a: lhs.a * rhs.a + lhs.b * rhs.c,
            b: lhs.a * rhs.b + lhs.b * rhs.d,
            c: lhs.c * rhs.a + lhs.d * rhs.c,
            d: lhs.c * rhs.b + lhs.d * rhs.d,
            e: lhs.e * rhs.a + lhs.f * rhs.c + rhs.e,
            f: lhs.e * rhs.b + lhs.f * rhs.d + rhs.f
        )
    }

    /// Apply the Td operator: move to next line offset by (tx, ty)
    ///
    /// Per ISO 32000-2:2020, Section 9.4.2 (Td operator):
    /// > Tm = Tlm = [1 0 0; 0 1 0; tx ty 1] × Tlm
    ///
    /// - Parameters:
    ///   - tx: Horizontal offset
    ///   - ty: Vertical offset
    ///   - lineMatrix: The current text line matrix (Tlm)
    /// - Returns: The new text matrix (also becomes new Tlm)
    public static func td(tx: Double, ty: Double, lineMatrix: Self) -> Self {
        .concatenating(.translation(tx: tx, ty: ty), lineMatrix)
    }

    /// Compute the text rendering matrix (Trm)
    ///
    /// The complete transformation from text space to device space.
    ///
    /// Per ISO 32000-2:2020, Section 9.4.4:
    /// > Trm = [Tfs×Th  0      0  ]
    /// >       [0       Tfs    0  ] × Tm × CTM
    /// >       [0       Trise  1  ]
    ///
    /// - Parameters:
    ///   - textMatrix: Current text matrix (Tm)
    ///   - fontSize: Text font size (Tfs)
    ///   - horizontalScaling: Horizontal scaling as percentage (Th)
    ///   - rise: Text rise (Trise)
    ///   - ctm: Current transformation matrix (CTM)
    /// - Returns: The text rendering matrix (Trm)
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Section 9.4.4 — Text space details
    public static func rendering(
        textMatrix: Self,
        fontSize: Double,
        horizontalScaling: Double,
        rise: Double,
        ctm: Self
    ) -> Self {
        let th = horizontalScaling / 100.0

        // Build the font size/scaling matrix
        let fontMatrix = Self(
            a: fontSize * th,
            b: 0,
            c: 0,
            d: fontSize,
            e: 0,
            f: rise
        )

        // Concatenate: fontMatrix × Tm × CTM
        return .concatenating(.concatenating(fontMatrix, textMatrix), ctm)
    }
}

// MARK: - 9.4.4 Glyph Displacement

extension ISO_32000.`9`.`4` {
    /// Glyph displacement calculation
    ///
    /// Per ISO 32000-2:2020, Section 9.4.4:
    /// > tx = ((w0 - Tj/1000) × Tfs + Tc + Tw) × Th
    /// > ty = (w1 - Tj/1000) × Tfs + Tc + Tw
    ///
    /// where:
    /// - w0, w1: glyph's horizontal and vertical displacements
    /// - Tj: position adjustment from TJ array (if any)
    /// - Tfs: text font size
    /// - Th: horizontal scaling
    /// - Tc: character spacing
    /// - Tw: word spacing (only for space character)
    public enum Displacement {}
}

extension ISO_32000.`9`.`4`.Displacement {
    /// Calculate horizontal displacement for a glyph
    ///
    /// - Parameters:
    ///   - glyphWidth: The glyph's width (w0) in text space units
    ///   - adjustment: Position adjustment from TJ array (in thousandths)
    ///   - fontSize: Text font size (Tfs)
    ///   - characterSpacing: Character spacing (Tc)
    ///   - wordSpacing: Word spacing (Tw), applied only for space
    ///   - horizontalScaling: Horizontal scaling percentage (Th)
    ///   - isSpace: Whether this is a space character (0x20)
    /// - Returns: The horizontal displacement (tx)
    public static func horizontal(
        glyphWidth: Double,
        adjustment: Double = 0,
        fontSize: Double,
        characterSpacing: Double,
        wordSpacing: Double,
        horizontalScaling: Double,
        isSpace: Bool
    ) -> Double {
        let th = horizontalScaling / 100.0
        let tw = isSpace ? wordSpacing : 0
        return ((glyphWidth - adjustment / 1000.0) * fontSize + characterSpacing + tw) * th
    }

    /// Calculate vertical displacement for a glyph (vertical writing mode)
    ///
    /// - Parameters:
    ///   - glyphHeight: The glyph's height (w1) in text space units
    ///   - adjustment: Position adjustment from TJ array (in thousandths)
    ///   - fontSize: Text font size (Tfs)
    ///   - characterSpacing: Character spacing (Tc)
    ///   - wordSpacing: Word spacing (Tw), applied only for space
    ///   - isSpace: Whether this is a space character (0x20)
    /// - Returns: The vertical displacement (ty)
    public static func vertical(
        glyphHeight: Double,
        adjustment: Double = 0,
        fontSize: Double,
        characterSpacing: Double,
        wordSpacing: Double,
        isSpace: Bool
    ) -> Double {
        let tw = isSpace ? wordSpacing : 0
        return (glyphHeight - adjustment / 1000.0) * fontSize + characterSpacing + tw
    }
}

// MARK: - TJ Array Element

extension ISO_32000.`9`.`4` {
    /// Element in a TJ array
    ///
    /// Per ISO 32000-2:2020, Table 107 (TJ operator):
    /// > Each element of array shall be either a string or a number.
    /// > If the element is a string, this operator shall show the string.
    /// > If it is a number, the operator shall adjust the text position.
    ///
    /// The number is expressed in thousandths of a unit of text space
    /// and is subtracted from the current position.
    public enum TJElement: Sendable {
        /// A text string to show (bytes, not decoded)
        case string([Byte])

        /// A position adjustment in thousandths of text space unit
        ///
        /// Positive values move left (horizontal) or down (vertical).
        case adjustment(Double)
    }
}

// MARK: - Convenience Typealiases

extension ISO_32000.Text {
    /// Text matrix
    public typealias Matrix = ISO_32000.`9`.`4`.Matrix

    /// TJ array element
    public typealias TJElement = ISO_32000.`9`.`4`.TJElement
}
