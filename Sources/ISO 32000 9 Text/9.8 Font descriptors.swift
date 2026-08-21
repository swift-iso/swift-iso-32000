public import Byte_Primitives
import ISO_32000_8_Graphics
import ISO_32000_Annex_D
public import ISO_32000_Shared

extension ISO_32000.`9` {

    public enum `8` {}
}

extension ISO_32000.`9`.`8` {

    public enum FontDesign {}
}

extension Tagged: @retroactive AdditiveArithmetic
where Tag == ISO_32000.`9`.`8`.FontDesign, Underlying: AdditiveArithmetic {

    @inlinable
    public static var zero: Self { Self(_unchecked: Underlying.zero) }

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying - rhs.underlying)
    }
}

extension ISO_32000.FontDesign.Width {

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

    @inlinable
    public func scaled(
        by fontSize: ISO_32000.UserSpace.Size<1>,
        unitsPerEm: Int = 1000
    ) -> ISO_32000.UserSpace.Height {
        let scale = fontSize.length.underlying / Double(unitsPerEm)
        return ISO_32000.UserSpace.Height(Double(self.underlying) * scale)
    }
}

extension ISO_32000.`9`.`8` {

    public struct Metrics: Sendable {

        private let widths: [UInt32: ISO_32000.FontDesign.Width]

        private let defaultWidth: ISO_32000.FontDesign.Width

        private let winAnsiByteWidths: [ISO_32000.FontDesign.Width]

        public let ascender: ISO_32000.FontDesign.Height

        public let descender: ISO_32000.FontDesign.Height

        public let capHeight: ISO_32000.FontDesign.Height

        public let xHeight: ISO_32000.FontDesign.Height

        public let leading: ISO_32000.FontDesign.Height

        public let unitsPerEm: Int

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

            var byteWidths = [ISO_32000.FontDesign.Width](repeating: typedDefaultWidth, count: 256)
            for byte in UInt8.min...UInt8.max {

                if let scalar = ISO_32000.WinAnsiEncoding.decode(Byte(byte)) {
                    byteWidths[Int(byte)] = typedWidths[scalar.value] ?? typedDefaultWidth
                }
            }
            self.winAnsiByteWidths = byteWidths
        }
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    public func width(forCodePoint codePoint: UInt32) -> Int {
        (widths[codePoint] ?? defaultWidth).underlying
    }

    public var missingWidth: Int { defaultWidth.underlying }

    public func width(of byte: Byte) -> ISO_32000.FontDesign.Width {
        winAnsiByteWidths[Int(byte.underlying)]
    }

    public func width<Bytes: Collection>(of bytes: Bytes) -> ISO_32000.FontDesign.Width
    where Bytes.Element == Byte {
        var total = 0
        for byte in bytes {
            total += winAnsiByteWidths[Int(byte.underlying)].underlying
        }
        return ISO_32000.FontDesign.Width(total)
    }

    public func width<Bytes: Collection>(
        of bytes: Bytes,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width where Bytes.Element == Byte {
        width(of: bytes).scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func glyphWidth(for scalar: UnicodeScalar) -> ISO_32000.FontDesign.Width {

        if let byte = ISO_32000.WinAnsiEncoding.encode(scalar) {
            return width(of: byte)
        }
        return defaultWidth
    }

    public func width(of text: String) -> ISO_32000.FontDesign.Width {
        var total = 0
        for scalar in text.unicodeScalars {

            if let byte = ISO_32000.WinAnsiEncoding.encode(scalar) {
                total += winAnsiByteWidths[Int(byte.underlying)].underlying
            } else {
                total += defaultWidth.underlying
            }
        }
        return ISO_32000.FontDesign.Width(total)
    }

    public func width(
        of text: String,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width {
        width(of: text).scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public var winAnsi: WinAnsi { WinAnsi(metrics: self) }

    public struct WinAnsi: Sendable {
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.WinAnsi {

    public func width(of byte: Byte) -> ISO_32000.FontDesign.Width {
        metrics.width(of: byte)
    }

    public func width<Bytes: Collection>(of bytes: Bytes) -> ISO_32000.FontDesign.Width
    where Bytes.Element == Byte {
        metrics.width(of: bytes)
    }

    public func width<Bytes: Collection>(
        of bytes: Bytes,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width where Bytes.Element == Byte {
        metrics.width(of: bytes, atSize: fontSize)
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    public var lineHeight: ISO_32000.FontDesign.Height {
        ascender - descender
    }

    public var normalLineHeight: ISO_32000.FontDesign.Height {
        ascender - descender + leading
    }

    public func lineHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        lineHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func normalLineHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        normalLineHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func ascender(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        ascender.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func descender(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        descender.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func xHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        xHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public func capHeight(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Height {
        capHeight.scaled(by: fontSize, unitsPerEm: unitsPerEm)
    }

    public var line: Line { Line(metrics: self) }

    public struct Line: Sendable {
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.Line {

    public var height: Multiplier {
        let h = metrics.ascender.underlying - metrics.descender.underlying
        return Multiplier(Double(h) / Double(metrics.unitsPerEm))
    }

    public var normal: Multiplier {
        let h =
            metrics.ascender.underlying - metrics.descender.underlying
            + metrics.leading.underlying
        return Multiplier(Double(h) / Double(metrics.unitsPerEm))
    }

    public struct Multiplier: Sendable {
        public let value: Double

        public init(_ value: Double) {
            self.value = value
        }
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    public var bullet: Glyph {
        Glyph(scalar: "\u{2022}", metrics: self)
    }

    public struct Glyph: Sendable {
        let scalar: UnicodeScalar
        let metrics: ISO_32000.`9`.`8`.Metrics
    }
}

extension ISO_32000.`9`.`8`.Metrics.Glyph {

    public var width: ISO_32000.FontDesign.Width {
        metrics.glyphWidth(for: scalar)
    }

    public func width(
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width {
        width.scaled(by: fontSize, unitsPerEm: metrics.unitsPerEm)
    }
}

extension ISO_32000.`9`.`8`.Metrics {

    public static let helvetica = Self(
        widths: [

            32: 278, 33: 278, 34: 355, 35: 556, 36: 556, 37: 889, 38: 667, 39: 191,
            40: 333, 41: 333, 42: 389, 43: 584, 44: 278, 45: 333, 46: 278, 47: 278,

            48: 556, 49: 556, 50: 556, 51: 556, 52: 556, 53: 556, 54: 556, 55: 556,
            56: 556, 57: 556,

            58: 278, 59: 278, 60: 584, 61: 584, 62: 584, 63: 556, 64: 1015,

            65: 667, 66: 667, 67: 722, 68: 722, 69: 667, 70: 611, 71: 778,
            72: 722, 73: 278, 74: 500, 75: 667, 76: 556, 77: 833, 78: 722, 79: 778,
            80: 667, 81: 778, 82: 722, 83: 667, 84: 611, 85: 722, 86: 667, 87: 944,
            88: 667, 89: 667, 90: 611,

            91: 278, 92: 278, 93: 278, 94: 469, 95: 556, 96: 333,

            97: 556, 98: 556, 99: 500, 100: 556, 101: 556, 102: 278, 103: 556,
            104: 556, 105: 222, 106: 222, 107: 500, 108: 222, 109: 833, 110: 556,
            111: 556, 112: 556, 113: 556, 114: 333, 115: 500, 116: 278, 117: 556,
            118: 500, 119: 722, 120: 500, 121: 500, 122: 500,

            123: 334, 124: 260, 125: 334, 126: 584,

            0x20AC: 556,
            0x201A: 222,
            0x0192: 556,
            0x201E: 333,
            0x2026: 1000,
            0x2020: 556,
            0x2021: 556,
            0x02C6: 333,
            0x2030: 1000,
            0x0160: 667,
            0x2039: 333,
            0x0152: 1000,
            0x017D: 611,

            0x2018: 222,
            0x2019: 222,
            0x201C: 333,
            0x201D: 333,
            0x2022: 350,
            0x2013: 556,
            0x2014: 1000,
            0x02DC: 333,
            0x2122: 1000,
            0x0161: 500,
            0x203A: 333,
            0x0153: 944,
            0x017E: 500,
            0x0178: 667,

            0x00A0: 278,
            0x00A1: 333,
            0x00A2: 556,
            0x00A3: 556,
            0x00A4: 556,
            0x00A5: 556,
            0x00A6: 260,
            0x00A7: 556,
            0x00A8: 333,
            0x00A9: 737,
            0x00AA: 370,
            0x00AB: 556,
            0x00AC: 584,
            0x00AD: 333,
            0x00AE: 737,
            0x00AF: 333,
            0x00B0: 400,
            0x00B1: 584,
            0x00B2: 333,
            0x00B3: 333,
            0x00B4: 333,
            0x00B5: 556,
            0x00B6: 537,
            0x00B7: 278,
            0x00B8: 333,
            0x00B9: 333,
            0x00BA: 365,
            0x00BB: 556,
            0x00BC: 834,
            0x00BD: 834,
            0x00BE: 834,
            0x00BF: 611,

            0x00C0: 667, 0x00C1: 667, 0x00C2: 667, 0x00C3: 667, 0x00C4: 667, 0x00C5: 667,
            0x00C6: 1000,
            0x00C7: 722,
            0x00C8: 667, 0x00C9: 667, 0x00CA: 667, 0x00CB: 667,
            0x00CC: 278, 0x00CD: 278, 0x00CE: 278, 0x00CF: 278,
            0x00D0: 722,
            0x00D1: 722,
            0x00D2: 778, 0x00D3: 778, 0x00D4: 778, 0x00D5: 778, 0x00D6: 778,
            0x00D7: 584,
            0x00D8: 778,
            0x00D9: 722, 0x00DA: 722, 0x00DB: 722, 0x00DC: 722,
            0x00DD: 667,
            0x00DE: 667,
            0x00DF: 611,

            0x00E0: 556, 0x00E1: 556, 0x00E2: 556, 0x00E3: 556, 0x00E4: 556, 0x00E5: 556,
            0x00E6: 889,
            0x00E7: 500,
            0x00E8: 556, 0x00E9: 556, 0x00EA: 556, 0x00EB: 556,
            0x00EC: 278, 0x00ED: 278, 0x00EE: 278, 0x00EF: 278,
            0x00F0: 556,
            0x00F1: 556,
            0x00F2: 556, 0x00F3: 556, 0x00F4: 556, 0x00F5: 556, 0x00F6: 556,
            0x00F7: 584,
            0x00F8: 611,
            0x00F9: 556, 0x00FA: 556, 0x00FB: 556, 0x00FC: 556,
            0x00FD: 500,
            0x00FE: 556,
            0x00FF: 500,
        ],
        defaultWidth: 556,
        ascender: 718,
        descender: -207,
        capHeight: 718,
        xHeight: 523
    )

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

    public static let courier = Self(
        widths: [:],
        defaultWidth: 600,
        ascender: 629,
        descender: -157,
        capHeight: 562,
        xHeight: 426
    )

    public static let symbol = Self(
        widths: [:],
        defaultWidth: 500,
        ascender: 0,
        descender: 0,
        capHeight: 0,
        xHeight: 0
    )

    public static let zapfDingbats = Self(
        widths: [:],
        defaultWidth: 500,
        ascender: 820,
        descender: -143,
        capHeight: 0,
        xHeight: 0
    )
}
