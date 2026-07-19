// ISO 32000-2:2020, 9.8 Font descriptors
//
// Sections:
//   9.8.1  General
//   9.8.2  Font descriptor flags
//   9.8.3  Font metrics

public import Byte_Primitives
import ISO_32000_8_Graphics
import ISO_32000_Annex_D
public import ISO_32000_Shared

extension ISO_32000.`9` {
    /// ISO 32000-2:2020, 9.8 Font descriptors
    public enum `8` {}
}

// MARK: - 9.8.3 Font Design Units

extension ISO_32000.`9`.`8` {
    /// Font design space namespace
    ///
    /// Per ISO 32000-2:2020, Section 9.8.3, font metrics are specified in
    /// font design units. For Type 1 fonts (including the Standard 14),
    /// the em square is 1000 units.
    public enum FontDesign {}
}

// MARK: - FontDesign Documentation
//
// ISO_32000.FontDesign is defined as Geometry<Int, ISO_32000.`9`.`8`.FontDesign>
// which provides the following types via the Geometry library:
//
// - Width:  horizontal displacement in font design units
// - Height: vertical displacement in font design units
// - X:      horizontal coordinate in font design units
// - Y:      vertical coordinate in font design units
// - Size<N>: N-dimensional size in font design units
//
// Font design units are integer-valued (1/1000 em for Type 1, 1/2048 for TrueType)

// MARK: - FontDesign Tagged Arithmetic

extension Tagged: AdditiveArithmetic
where Tag == ISO_32000.`9`.`8`.FontDesign, Underlying: AdditiveArithmetic {
    /// The zero value in font design units.
    @inlinable
    public static var zero: Self { Self(_unchecked: Underlying.zero) }

    /// Adds two font design unit values.
    ///
    /// Valid for accumulating glyph widths (e.g., total string width).
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying + rhs.underlying)
    }

    /// Subtracts one font design unit value from another.
    ///
    /// Valid for computing differences (e.g., `ascender - descender` for line height).
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying - rhs.underlying)
    }
}

// MARK: - FontDesign to UserSpace Conversion

extension ISO_32000.FontDesign.Width {
    /// Convert font design width to user space at the given font size.
    ///
    /// Per ISO 32000-2:2020, Section 9.2.4:
    /// `userSpaceValue = fontDesignUnits × (fontSize / unitsPerEm)`
    ///
    /// - Parameters:
    ///   - fontSize: The font size in user space units (points at 1/72 inch)
    ///   - unitsPerEm: Units per em (1000 for Type 1, 2048 for TrueType). Default: 1000
    /// - Returns: Width in user space units
    ///
    /// ## Example
    ///
    /// ```swift
    /// let glyphWidth: ISO_32000.FontDesign.Width = 556  // Helvetica 'a'
    /// let fontSize: ISO_32000.UserSpace.Size<1> = .init(12)
    /// let actualWidth = glyphWidth.scaled(by: fontSize)  // 6.672 points
    /// ```
    @inlinable
    public func scaled(
        by fontSize: ISO_32000.UserSpace.Size<1>,
        unitsPerEm: Int = 1000
    ) -> ISO_32000.UserSpace.Width {
        let scale = fontSize.length.underlying / Double(unitsPerEm)
        return ISO_32000.UserSpace.Width(Double(self.underlying) * scale)
    }
}

extension ISO_32000.FontDesign.Height {
    /// Convert font design height to user space at the given font size.
    ///
    /// Per ISO 32000-2:2020, Section 9.2.4:
    /// `userSpaceValue = fontDesignUnits × (fontSize / unitsPerEm)`
    ///
    /// - Parameters:
    ///   - fontSize: The font size in user space units (points at 1/72 inch)
    ///   - unitsPerEm: Units per em (1000 for Type 1, 2048 for TrueType). Default: 1000
    /// - Returns: Height in user space units
    @inlinable
    public func scaled(
        by fontSize: ISO_32000.UserSpace.Size<1>,
        unitsPerEm: Int = 1000
    ) -> ISO_32000.UserSpace.Height {
        let scale = fontSize.length.underlying / Double(unitsPerEm)
        return ISO_32000.UserSpace.Height(Double(self.underlying) * scale)
    }
}

// MARK: - Font Metrics

extension ISO_32000.`9`.`8` {
    /// Font metrics for text measurement
    ///
    /// Per ISO 32000-2 Section 9.8, font descriptors contain metrics
    /// that describe the font's characteristics.
    ///
    /// Metrics are in font design units (1000 units per em for Type 1 fonts).
    /// Use the `atSize(_:)` method on `FontDesign.Unit2` to convert to user space.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Section 9.8.3 — Font metrics
    /// ISO 32000-2:2020, Table 121 — Entries common to all font descriptors
    public struct Metrics: Sendable {
        /// Glyph width table (in font design units)
        private let widths: [UInt32: ISO_32000.FontDesign.Width]

        /// Default width for missing glyphs (in font design units)
        private let defaultWidth: ISO_32000.FontDesign.Width

        /// Pre-computed WinAnsi byte-to-width lookup table (256 entries)
        ///
        /// This enables O(1) width lookups for WinAnsi-encoded bytes without
        /// needing to decode to Unicode first. Computed once at initialization.
        private let winAnsiByteWidths: [ISO_32000.FontDesign.Width]

        /// Ascent: maximum height above the baseline reached by glyphs
        ///
        /// Per ISO 32000-2 Table 121:
        /// > (Required, except for Type 3 fonts) The maximum height above the
        /// > baseline reached by glyphs in this font.
        public let ascender: ISO_32000.FontDesign.Height

        /// Descent: maximum depth below the baseline reached by glyphs
        ///
        /// Per ISO 32000-2 Table 121:
        /// > (Required, except for Type 3 fonts) The maximum depth below the
        /// > baseline reached by glyphs in this font. The value shall be a
        /// > negative number.
        public let descender: ISO_32000.FontDesign.Height

        /// Cap height: vertical coordinate of the top of flat capital letters
        ///
        /// Per ISO 32000-2 Table 121:
        /// > (Required for fonts that have Latin characters, except for Type 3
        /// > fonts) The y coordinate of the top of flat capital letters,
        /// > measured from the baseline.
        public let capHeight: ISO_32000.FontDesign.Height

        /// x-height: vertical coordinate of the top of flat nonascending lowercase letters
        ///
        /// Per ISO 32000-2 Table 121:
        /// > (Optional) The font's x height: the vertical coordinate of the top
        /// > of flat nonascending lowercase letters (like the letter x),
        /// > measured from the baseline.
        public let xHeight: ISO_32000.FontDesign.Height

        /// Leading: desired spacing between baselines of consecutive lines of text
        ///
        /// Per ISO 32000-2 Table 121:
        /// > (Optional) The spacing between baselines of consecutive lines of text.
        /// > Default value: 0.
        ///
        /// The normal line height (CSS `line-height: normal`) is computed as:
        /// `ascender - descender + leading`
        public let leading: ISO_32000.FontDesign.Height

        /// Units per em square
        ///
        /// - Type 1 fonts: 1000 units per em
        /// - TrueType fonts: typically 2048 units per em (but variable)
        public let unitsPerEm: Int

        /// Create metrics with a width table and vertical metrics
        public init(
            widths: [UInt32: Int],
            defaultWidth: Int,
            ascender: Int,
            descender: Int,
            capHeight: Int,
            xHeight: Int,
            leading: Int = 0,
            unitsPerEm: Int = 1000
        ) {
            let typedWidths = widths.mapValues { ISO_32000.FontDesign.Width($0) }
            let typedDefaultWidth = ISO_32000.FontDesign.Width(defaultWidth)

            self.widths = typedWidths
            self.defaultWidth = typedDefaultWidth
            self.ascender = ISO_32000.FontDesign.Height(ascender)
            self.descender = ISO_32000.FontDesign.Height(descender)
            self.capHeight = ISO_32000.FontDesign.Height(capHeight)
            self.xHeight = ISO_32000.FontDesign.Height(xHeight)
            self.leading = ISO_32000.FontDesign.Height(leading)
            self.unitsPerEm = unitsPerEm

            // Pre-compute WinAnsi byte-to-width lookup table
            // This eliminates the decode step in the hot path
            var byteWidths = [ISO_32000.FontDesign.Width](repeating: typedDefaultWidth, count: 256)
            for byte in UInt8.min...UInt8.max {
                // `byte` stays UInt8 — it is also the array index; bridge to Byte
                // for the byte-domain WinAnsi decode.
                if let scalar = ISO_32000.WinAnsiEncoding.decode(Byte(byte)) {
                    byteWidths[Int(byte)] = typedWidths[scalar.value] ?? typedDefaultWidth
                }
            }
            self.winAnsiByteWidths = byteWidths
        }
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    /// Get the width for a Unicode code point.
    ///
    /// Returns the glyph width in font design units, or the default width
    /// if the code point is not in the width table.
    ///
    /// - Parameter codePoint: Unicode code point (e.g., 65 for 'A')
    /// - Returns: Width in font design units
    public func width(forCodePoint codePoint: UInt32) -> Int {
        (widths[codePoint] ?? defaultWidth).underlying
    }

    /// The default width for missing glyphs (in font design units).
    ///
    /// Used for characters not in the width table.
    public var missingWidth: Int { defaultWidth.underlying }

    // MARK: - Primitive: Byte Width (canonical)

    /// Get width of a single WinAnsi byte in font design units
    ///
    /// This is the canonical primitive - all other width calculations are composed from this.
    /// Uses pre-computed lookup table for O(1) access. The width table is indexed by the
    /// byte's arithmetic value, so the byte-domain `Byte` is bridged via `.underlying` here —
    /// the single arithmetic boundary, scoped to the table lookup.
    public func width(of byte: Byte) -> ISO_32000.FontDesign.Width {
        winAnsiByteWidths[Int(byte.underlying)]
    }

    /// Calculate width of WinAnsi-encoded bytes in font design units
    ///
    /// Uses pre-computed byte-to-width lookup table for O(1) per-byte access.
    public func width<Bytes: Collection>(of bytes: Bytes) -> ISO_32000.FontDesign.Width
    where Bytes.Element == Byte {
        var total = 0
        for byte in bytes {
            total += winAnsiByteWidths[Int(byte.underlying)].underlying
        }
        return ISO_32000.FontDesign.Width(total)
    }

    /// Calculate width of WinAnsi-encoded bytes at a specific font size (returns UserSpace)
    public func width<Bytes: Collection>(
        of bytes: Bytes,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width where Bytes.Element == Byte {
        width(of: bytes).scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    // MARK: - Composed: Scalar Width (via byte encoding)

    /// Get width of a single Unicode scalar in font design units
    ///
    /// Composed from byte primitive: encodes scalar to WinAnsi byte, then looks up width.
    /// Returns default width if scalar cannot be encoded in WinAnsi.
    public func glyphWidth(for scalar: UnicodeScalar) -> ISO_32000.FontDesign.Width {
        // encode vends Byte; the byte-width primitive now takes Byte directly.
        if let byte = ISO_32000.WinAnsiEncoding.encode(scalar) {
            return width(of: byte)
        }
        return defaultWidth
    }

    // MARK: - Composed: String Width (via byte encoding)

    /// Calculate width of a String in font design units
    ///
    /// Composed from byte primitive: encodes each scalar to WinAnsi, then sums widths.
    public func width(of text: String) -> ISO_32000.FontDesign.Width {
        var total = 0
        for scalar in text.unicodeScalars {
            // encode now vends Byte; the lookup table is indexed on the underlying UInt8.
            if let byte = ISO_32000.WinAnsiEncoding.encode(scalar) {
                total += winAnsiByteWidths[Int(byte.underlying)].underlying
            } else {
                total += defaultWidth.underlying
            }
        }
        return ISO_32000.FontDesign.Width(total)
    }

    /// Calculate width of a String at a specific font size (returns UserSpace)
    public func width(
        of text: String,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width {
        width(of: text).scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    // MARK: - WinAnsi Namespace (convenience)

    /// WinAnsi encoding operations on this font metrics
    ///
    /// Provides namespaced access to byte-based width calculations.
    /// The underlying implementation uses the same byte primitives.
    public var winAnsi: WinAnsi { WinAnsi(metrics: self) }

    /// WinAnsi encoding namespace for font metrics
    public struct WinAnsi: Sendable {
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.WinAnsi {
    /// Get width of a single WinAnsi byte in font design units
    public func width(of byte: Byte) -> ISO_32000.FontDesign.Width {
        metrics.width(of: byte)
    }

    /// Calculate width of WinAnsi-encoded bytes in font design units
    public func width<Bytes: Collection>(of bytes: Bytes) -> ISO_32000.FontDesign.Width
    where Bytes.Element == Byte {
        metrics.width(of: bytes)
    }

    /// Calculate width of WinAnsi-encoded bytes at a specific font size (returns UserSpace)
    public func width<Bytes: Collection>(
        of bytes: Bytes,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width where Bytes.Element == Byte {
        metrics.width(of: bytes, atSize: fontSize)
    }
}

extension ISO_32000.`9`.`8`.Metrics {
    /// Line height in font design units (ascender - descender)
    ///
    /// This is the minimum line height without any leading/line gap.
    public var lineHeight: ISO_32000.FontDesign.Height {
        ascender - descender
    }

    /// Normal line height in font design units (ascender - descender + leading)
    ///
    /// This corresponds to CSS `line-height: normal` and includes the font's
    /// recommended leading (from the Leading entry in the font descriptor).
    public var normalLineHeight: ISO_32000.FontDesign.Height {
        ascender - descender + leading
    }

    /// Line height at a specific font size (returns UserSpace)
    public func lineHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        lineHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    /// Normal line height at a specific font size (includes leading, returns UserSpace)
    public func normalLineHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        normalLineHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    /// Ascender at a specific font size (returns UserSpace)
    public func ascender(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        ascender.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    /// Descender at a specific font size (negative value, returns UserSpace)
    public func descender(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        descender.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    /// x-height at a specific font size (returns UserSpace)
    public func xHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        xHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    /// Cap height at a specific font size (returns UserSpace)
    public func capHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        capHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    // MARK: - Line Height Multipliers

    /// Line height metrics as multipliers (relative to font size).
    ///
    /// This provides CSS-compatible line height multipliers:
    /// - `line.height.value` is `(ascender - descender) / unitsPerEm` (the base 1.0 factor)
    /// - `line.normal.value` is `(ascender - descender + leading) / unitsPerEm`
    public var line: Line { Line(metrics: self) }

    /// Line height multipliers namespace.
    public struct Line: Sendable {
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.Line {
    /// Base line height as a multiplier (ascender - descender) / unitsPerEm.
    ///
    /// This is the ratio of the typographic line height to the em square.
    public var height: Multiplier {
        let h = metrics.ascender.underlying - metrics.descender.underlying
        return Multiplier(Double(h) / Double(metrics.unitsPerEm))
    }

    /// Normal line height as a multiplier (ascender - descender + leading) / unitsPerEm.
    ///
    /// This corresponds to CSS `line-height: normal` and includes the font's
    /// recommended leading (from the Leading entry in the font descriptor).
    public var normal: Multiplier {
        let h =
            metrics.ascender.underlying - metrics.descender.underlying
            + metrics.leading.underlying
        return Multiplier(Double(h) / Double(metrics.unitsPerEm))
    }

    /// A multiplier value (dimensionless ratio).
    public struct Multiplier: Sendable {
        public let value: Double

        public init(_ value: Double) {
            self.value = value
        }
    }
}

extension ISO_32000.`9`.`8`.Metrics {
    // MARK: - Glyph Accessors

    /// Bullet glyph metrics (U+2022, •).
    ///
    /// Provides access to the bullet character metrics for list marker sizing.
    /// The bullet width is the designed size of the disc marker.
    ///
    /// ## Usage
    /// ```swift
    /// let width = metrics.bullet.width              // In font design units
    /// let width = metrics.bullet.width(atSize: 12)  // In user space units
    /// ```
    public var bullet: Glyph {
        Glyph(scalar: "\u{2022}", metrics: self)
    }

    /// Accessor for individual glyph metrics.
    public struct Glyph: Sendable {
        let scalar: UnicodeScalar
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.Glyph {
    /// Glyph width in font design units (1/1000 em)
    public var width: ISO_32000.FontDesign.Width {
        metrics.glyphWidth(for: scalar)
    }

    /// Glyph width at a specific font size (returns UserSpace)
    public func width(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width {
        width.scaled(by: fontSize, unitsPerEm: metrics.unitsPerEm)
    }
}

// MARK: - Pre-defined Metrics (Standard 14 Fonts)

extension ISO_32000.`9`.`8`.Metrics {
    /// Helvetica metrics (from Adobe AFM)
    ///
    /// Source: https://github.com/Hopding/standard-fonts/blob/master/font_metrics/Helvetica.afm
    public static let helvetica = Self(
        widths: [
            // Space and punctuation (32-47)
            32: 278, 33: 278, 34: 355, 35: 556, 36: 556, 37: 889, 38: 667, 39: 191,
            40: 333, 41: 333, 42: 389, 43: 584, 44: 278, 45: 333, 46: 278, 47: 278,
            // Digits (48-57)
            48: 556, 49: 556, 50: 556, 51: 556, 52: 556, 53: 556, 54: 556, 55: 556,
            56: 556, 57: 556,
            // Punctuation (58-64)
            58: 278, 59: 278, 60: 584, 61: 584, 62: 584, 63: 556, 64: 1015,
            // Uppercase (65-90)
            65: 667, 66: 667, 67: 722, 68: 722, 69: 667, 70: 611, 71: 778,
            72: 722, 73: 278, 74: 500, 75: 667, 76: 556, 77: 833, 78: 722, 79: 778,
            80: 667, 81: 778, 82: 722, 83: 667, 84: 611, 85: 722, 86: 667, 87: 944,
            88: 667, 89: 667, 90: 611,
            // Brackets (91-96)
            91: 278, 92: 278, 93: 278, 94: 469, 95: 556, 96: 333,
            // Lowercase (97-122)
            97: 556, 98: 556, 99: 500, 100: 556, 101: 556, 102: 278, 103: 556,
            104: 556, 105: 222, 106: 222, 107: 500, 108: 222, 109: 833, 110: 556,
            111: 556, 112: 556, 113: 556, 114: 333, 115: 500, 116: 278, 117: 556,
            118: 500, 119: 722, 120: 500, 121: 500, 122: 500,
            // Braces (123-126)
            123: 334, 124: 260, 125: 334, 126: 584,

            // Extended characters (WinAnsi encoding 128-255, keyed by Unicode scalar)
            // Currency and symbols
            0x20AC: 556,  // Euro sign (WinAnsi 0x80)
            0x201A: 222,  // quotesinglbase (WinAnsi 0x82)
            0x0192: 556,  // florin (WinAnsi 0x83)
            0x201E: 333,  // quotedblbase (WinAnsi 0x84)
            0x2026: 1000,  // ellipsis (WinAnsi 0x85)
            0x2020: 556,  // dagger (WinAnsi 0x86)
            0x2021: 556,  // daggerdbl (WinAnsi 0x87)
            0x02C6: 333,  // circumflex (WinAnsi 0x88)
            0x2030: 1000,  // perthousand (WinAnsi 0x89)
            0x0160: 667,  // Scaron (WinAnsi 0x8A)
            0x2039: 333,  // guilsinglleft (WinAnsi 0x8B)
            0x0152: 1000,  // OE (WinAnsi 0x8C)
            0x017D: 611,  // Zcaron (WinAnsi 0x8E)

            // Quotes and punctuation
            0x2018: 222,  // quoteleft (WinAnsi 0x91)
            0x2019: 222,  // quoteright (WinAnsi 0x92)
            0x201C: 333,  // quotedblleft (WinAnsi 0x93)
            0x201D: 333,  // quotedblright (WinAnsi 0x94)
            0x2022: 350,  // bullet (WinAnsi 0x95) *** KEY FOR LIST MARKERS ***
            0x2013: 556,  // endash (WinAnsi 0x96)
            0x2014: 1000,  // emdash (WinAnsi 0x97)
            0x02DC: 333,  // tilde (WinAnsi 0x98)
            0x2122: 1000,  // trademark (WinAnsi 0x99)
            0x0161: 500,  // scaron (WinAnsi 0x9A)
            0x203A: 333,  // guilsinglright (WinAnsi 0x9B)
            0x0153: 944,  // oe (WinAnsi 0x9C)
            0x017E: 500,  // zcaron (WinAnsi 0x9E)
            0x0178: 667,  // Ydieresis (WinAnsi 0x9F)

            // Latin-1 Supplement (160-255)
            0x00A0: 278,  // nbspace
            0x00A1: 333,  // exclamdown
            0x00A2: 556,  // cent
            0x00A3: 556,  // sterling
            0x00A4: 556,  // currency
            0x00A5: 556,  // yen
            0x00A6: 260,  // brokenbar
            0x00A7: 556,  // section
            0x00A8: 333,  // dieresis
            0x00A9: 737,  // copyright
            0x00AA: 370,  // ordfeminine
            0x00AB: 556,  // guillemotleft
            0x00AC: 584,  // logicalnot
            0x00AD: 333,  // softhyphen
            0x00AE: 737,  // registered
            0x00AF: 333,  // macron
            0x00B0: 400,  // degree
            0x00B1: 584,  // plusminus
            0x00B2: 333,  // twosuperior
            0x00B3: 333,  // threesuperior
            0x00B4: 333,  // acute
            0x00B5: 556,  // mu
            0x00B6: 537,  // paragraph
            0x00B7: 278,  // periodcentered
            0x00B8: 333,  // cedilla
            0x00B9: 333,  // onesuperior
            0x00BA: 365,  // ordmasculine
            0x00BB: 556,  // guillemotright
            0x00BC: 834,  // onequarter
            0x00BD: 834,  // onehalf
            0x00BE: 834,  // threequarters
            0x00BF: 611,  // questiondown

            // Uppercase accented (192-223)
            0x00C0: 667, 0x00C1: 667, 0x00C2: 667, 0x00C3: 667, 0x00C4: 667, 0x00C5: 667,  // À-Å
            0x00C6: 1000,  // Æ
            0x00C7: 722,  // Ç
            0x00C8: 667, 0x00C9: 667, 0x00CA: 667, 0x00CB: 667,  // È-Ë
            0x00CC: 278, 0x00CD: 278, 0x00CE: 278, 0x00CF: 278,  // Ì-Ï
            0x00D0: 722,  // Ð
            0x00D1: 722,  // Ñ
            0x00D2: 778, 0x00D3: 778, 0x00D4: 778, 0x00D5: 778, 0x00D6: 778,  // Ò-Ö
            0x00D7: 584,  // multiply
            0x00D8: 778,  // Ø
            0x00D9: 722, 0x00DA: 722, 0x00DB: 722, 0x00DC: 722,  // Ù-Ü
            0x00DD: 667,  // Ý
            0x00DE: 667,  // Þ
            0x00DF: 611,  // germandbls (ß)

            // Lowercase accented (224-255)
            0x00E0: 556, 0x00E1: 556, 0x00E2: 556, 0x00E3: 556, 0x00E4: 556, 0x00E5: 556,  // à-å
            0x00E6: 889,  // æ
            0x00E7: 500,  // ç
            0x00E8: 556, 0x00E9: 556, 0x00EA: 556, 0x00EB: 556,  // è-ë
            0x00EC: 278, 0x00ED: 278, 0x00EE: 278, 0x00EF: 278,  // ì-ï
            0x00F0: 556,  // ð
            0x00F1: 556,  // ñ
            0x00F2: 556, 0x00F3: 556, 0x00F4: 556, 0x00F5: 556, 0x00F6: 556,  // ò-ö
            0x00F7: 584,  // divide
            0x00F8: 611,  // ø
            0x00F9: 556, 0x00FA: 556, 0x00FB: 556, 0x00FC: 556,  // ù-ü
            0x00FD: 500,  // ý
            0x00FE: 556,  // þ
            0x00FF: 500,  // ÿ
        ],
        defaultWidth: 556,
        ascender: 718,
        descender: -207,
        capHeight: 718,
        xHeight: 523
    )

    /// Helvetica Bold metrics (from Adobe AFM)
    public static let helveticaBold = Self(
        widths: [
            32: 278, 33: 333, 34: 474, 35: 556, 36: 556, 37: 889, 38: 722, 39: 238,
            40: 333, 41: 333, 42: 389, 43: 584, 44: 278, 45: 333, 46: 278, 47: 278,
            48: 556, 49: 556, 50: 556, 51: 556, 52: 556, 53: 556, 54: 556, 55: 556,
            56: 556, 57: 556,
            58: 333, 59: 333, 60: 584, 61: 584, 62: 584, 63: 611,
            64: 975, 65: 722, 66: 722, 67: 722, 68: 722, 69: 667, 70: 611, 71: 778,
            72: 722, 73: 278, 74: 556, 75: 722, 76: 611, 77: 833, 78: 722, 79: 778,
            80: 667, 81: 778, 82: 722, 83: 667, 84: 611, 85: 722, 86: 667, 87: 944,
            88: 667, 89: 667, 90: 611,
            91: 333, 92: 278, 93: 333, 94: 584, 95: 556, 96: 333,
            97: 556, 98: 611, 99: 556, 100: 611, 101: 556, 102: 333, 103: 611,
            104: 611, 105: 278, 106: 278, 107: 556, 108: 278, 109: 889, 110: 611,
            111: 611, 112: 611, 113: 611, 114: 389, 115: 556, 116: 333, 117: 611,
            118: 556, 119: 778, 120: 556, 121: 556, 122: 500,
            123: 389, 124: 280, 125: 389, 126: 584,
        ],
        defaultWidth: 611,
        ascender: 718,
        descender: -207,
        capHeight: 718,
        xHeight: 532
    )

    /// Times Roman metrics (from Adobe AFM)
    public static let timesRoman = Self(
        widths: [
            32: 250, 33: 333, 34: 408, 35: 500, 36: 500, 37: 833, 38: 778, 39: 180,
            40: 333, 41: 333, 42: 500, 43: 564, 44: 250, 45: 333, 46: 250, 47: 278,
            48: 500, 49: 500, 50: 500, 51: 500, 52: 500, 53: 500, 54: 500, 55: 500,
            56: 500, 57: 500,
            58: 278, 59: 278, 60: 564, 61: 564, 62: 564, 63: 444,
            64: 921, 65: 722, 66: 667, 67: 667, 68: 722, 69: 611, 70: 556, 71: 722,
            72: 722, 73: 333, 74: 389, 75: 722, 76: 611, 77: 889, 78: 722, 79: 722,
            80: 556, 81: 722, 82: 667, 83: 556, 84: 611, 85: 722, 86: 722, 87: 944,
            88: 722, 89: 722, 90: 611,
            91: 333, 92: 278, 93: 333, 94: 469, 95: 500, 96: 333,
            97: 444, 98: 500, 99: 444, 100: 500, 101: 444, 102: 333, 103: 500,
            104: 500, 105: 278, 106: 278, 107: 500, 108: 278, 109: 778, 110: 500,
            111: 500, 112: 500, 113: 500, 114: 333, 115: 389, 116: 278, 117: 500,
            118: 500, 119: 722, 120: 500, 121: 500, 122: 444,
            123: 480, 124: 200, 125: 480, 126: 541,
        ],
        defaultWidth: 500,
        ascender: 683,
        descender: -217,
        capHeight: 662,
        xHeight: 450
    )

    /// Times Bold metrics (from Adobe AFM)
    public static let timesBold = Self(
        widths: [
            32: 250, 33: 333, 34: 555, 35: 500, 36: 500, 37: 1000, 38: 833, 39: 278,
            40: 333, 41: 333, 42: 500, 43: 570, 44: 250, 45: 333, 46: 250, 47: 278,
            48: 500, 49: 500, 50: 500, 51: 500, 52: 500, 53: 500, 54: 500, 55: 500,
            56: 500, 57: 500,
            58: 333, 59: 333, 60: 570, 61: 570, 62: 570, 63: 500,
            64: 930, 65: 722, 66: 667, 67: 722, 68: 722, 69: 667, 70: 611, 71: 778,
            72: 778, 73: 389, 74: 500, 75: 778, 76: 667, 77: 944, 78: 722, 79: 778,
            80: 611, 81: 778, 82: 722, 83: 556, 84: 667, 85: 722, 86: 722, 87: 1000,
            88: 722, 89: 722, 90: 667,
            91: 333, 92: 278, 93: 333, 94: 581, 95: 500, 96: 333,
            97: 500, 98: 556, 99: 444, 100: 556, 101: 444, 102: 333, 103: 500,
            104: 556, 105: 278, 106: 333, 107: 556, 108: 278, 109: 833, 110: 556,
            111: 500, 112: 556, 113: 556, 114: 444, 115: 389, 116: 333, 117: 556,
            118: 500, 119: 722, 120: 500, 121: 500, 122: 444,
            123: 394, 124: 220, 125: 394, 126: 520,
        ],
        defaultWidth: 556,
        ascender: 683,
        descender: -217,
        capHeight: 676,
        xHeight: 461
    )

    /// Courier metrics (monospaced - all glyphs are 600 units wide, from Adobe AFM)
    public static let courier = Self(
        widths: [:],
        defaultWidth: 600,
        ascender: 629,
        descender: -157,
        capHeight: 562,
        xHeight: 426
    )

    /// Symbol metrics (from Adobe AFM)
    public static let symbol = Self(
        widths: [:],
        defaultWidth: 500,
        ascender: 0,
        descender: 0,
        capHeight: 0,
        xHeight: 0
    )

    /// ZapfDingbats metrics (from Adobe AFM)
    public static let zapfDingbats = Self(
        widths: [:],
        defaultWidth: 500,
        ascender: 820,
        descender: -143,
        capHeight: 0,
        xHeight: 0
    )
}
