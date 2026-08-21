public import Byte_Primitives
public import ISO_32000_7_Syntax
import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import Ownership_Primitives

extension ISO_32000.`9` {

    public enum `6` {}
}

extension ISO_32000.`9`.`6` {

    public struct Font: Sendable {

        private let _storage: Ownership.Immutable<Storage>

        public init(
            baseFontName: ISO_32000.`7`.`3`.COS.Name,
            resourceName: ISO_32000.`7`.`3`.COS.Name,
            metrics: ISO_32000.`9`.`8`.Metrics,
            isMonospaced: Bool,
            weight: Weight,
            style: Style,
            family: Family,
            embeddedSource: Embedded? = nil
        ) {
            self._storage = Ownership.Immutable(
                Storage(
                    baseFontName: baseFontName,
                    resourceName: resourceName,
                    metrics: metrics,
                    isMonospaced: isMonospaced,
                    weight: weight,
                    style: style,
                    family: family,
                    embeddedSource: embeddedSource
                )
            )
        }
    }
}

extension ISO_32000.`9`.`6`.Font {
    public var baseFontName: ISO_32000.`7`.`3`.COS.Name { _storage.value.baseFontName }
    public var resourceName: ISO_32000.`7`.`3`.COS.Name { _storage.value.resourceName }
    public var metrics: ISO_32000.`9`.`8`.Metrics { _storage.value.metrics }
    public var isMonospaced: Bool { _storage.value.isMonospaced }
    public var weight: Weight { _storage.value.weight }
    public var style: Style { _storage.value.style }
    public var family: Family { _storage.value.family }
    public var embeddedSource: ISO_32000.`9`.`6`.Embedded? { _storage.value.embeddedSource }
    public var isEmbedded: Bool { embeddedSource != nil }

    struct Storage: Sendable {
        let baseFontName: ISO_32000.`7`.`3`.COS.Name
        let resourceName: ISO_32000.`7`.`3`.COS.Name
        let metrics: ISO_32000.`9`.`8`.Metrics
        let isMonospaced: Bool
        let weight: Weight
        let style: Style
        let family: Family
        let embeddedSource: ISO_32000.`9`.`6`.Embedded?
    }
}

extension ISO_32000.`9`.`6`.Font: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.baseFontName == rhs.baseFontName
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(baseFontName)
    }
}

extension ISO_32000.`9`.`6`.Font {

    public enum Weight: Sendable, Hashable {
        case regular
        case bold
    }

    public enum Style: Sendable, Hashable {
        case normal
        case italic
        case oblique
    }

    public enum Family: String, Sendable, Hashable {
        case helvetica = "Helvetica"
        case times = "Times"
        case courier = "Courier"
        case symbol = "Symbol"
        case zapfDingbats = "ZapfDingbats"

        case custom = "Custom"
    }
}

extension ISO_32000.`9`.`6`.Font {

    public struct Helvetica: Sendable {
        private init() {}
    }

    public struct Times: Sendable {
        private init() {}
    }

    public struct Courier: Sendable {
        private init() {}
    }

    public struct Symbol: Sendable {
        private init() {}
    }

    public struct ZapfDingbats: Sendable {
        private init() {}
    }

    public static var helvetica: Self { Helvetica.regular }

    public static var times: Self { Times.regular }

    public static var courier: Self { Courier.regular }

    public static var symbol: Self { Symbol.regular }

    public static var zapfDingbats: Self { ZapfDingbats.regular }
}

extension ISO_32000.`9`.`6`.Font.Helvetica {

    public static let regular = ISO_32000.`9`.`6`.Font(
        baseFontName: .helvetica,
        resourceName: .f1,
        metrics: .helvetica,
        isMonospaced: false,
        weight: .regular,
        style: .normal,
        family: .helvetica
    )

    public static let bold = ISO_32000.`9`.`6`.Font(
        baseFontName: .helveticaBold,
        resourceName: .f2,
        metrics: .helveticaBold,
        isMonospaced: false,
        weight: .bold,
        style: .normal,
        family: .helvetica
    )

    public static let oblique = ISO_32000.`9`.`6`.Font(
        baseFontName: .helveticaOblique,
        resourceName: .f3,
        metrics: .helvetica,
        isMonospaced: false,
        weight: .regular,
        style: .oblique,
        family: .helvetica
    )

    public static let boldOblique = ISO_32000.`9`.`6`.Font(
        baseFontName: .helveticaBoldOblique,
        resourceName: .f4,
        metrics: .helveticaBold,
        isMonospaced: false,
        weight: .bold,
        style: .oblique,
        family: .helvetica
    )
}

extension ISO_32000.`9`.`6`.Font.Times {

    public static let regular = ISO_32000.`9`.`6`.Font(
        baseFontName: .timesRoman,
        resourceName: .f5,
        metrics: .timesRoman,
        isMonospaced: false,
        weight: .regular,
        style: .normal,
        family: .times
    )

    public static let bold = ISO_32000.`9`.`6`.Font(
        baseFontName: .timesBold,
        resourceName: .f6,
        metrics: .timesBold,
        isMonospaced: false,
        weight: .bold,
        style: .normal,
        family: .times
    )

    public static let italic = ISO_32000.`9`.`6`.Font(
        baseFontName: .timesItalic,
        resourceName: .f7,
        metrics: .timesRoman,
        isMonospaced: false,
        weight: .regular,
        style: .italic,
        family: .times
    )

    public static let boldItalic = ISO_32000.`9`.`6`.Font(
        baseFontName: .timesBoldItalic,
        resourceName: .f8,
        metrics: .timesBold,
        isMonospaced: false,
        weight: .bold,
        style: .italic,
        family: .times
    )
}

extension ISO_32000.`9`.`6`.Font.Courier {

    public static let regular = ISO_32000.`9`.`6`.Font(
        baseFontName: .courier,
        resourceName: .f9,
        metrics: .courier,
        isMonospaced: true,
        weight: .regular,
        style: .normal,
        family: .courier
    )

    public static let bold = ISO_32000.`9`.`6`.Font(
        baseFontName: .courierBold,
        resourceName: .f10,
        metrics: .courier,
        isMonospaced: true,
        weight: .bold,
        style: .normal,
        family: .courier
    )

    public static let oblique = ISO_32000.`9`.`6`.Font(
        baseFontName: .courierOblique,
        resourceName: .f11,
        metrics: .courier,
        isMonospaced: true,
        weight: .regular,
        style: .oblique,
        family: .courier
    )

    public static let boldOblique = ISO_32000.`9`.`6`.Font(
        baseFontName: .courierBoldOblique,
        resourceName: .f12,
        metrics: .courier,
        isMonospaced: true,
        weight: .bold,
        style: .oblique,
        family: .courier
    )
}

extension ISO_32000.`9`.`6`.Font.Symbol {

    public static let regular = ISO_32000.`9`.`6`.Font(
        baseFontName: .symbol,
        resourceName: .f13,
        metrics: .symbol,
        isMonospaced: false,
        weight: .regular,
        style: .normal,
        family: .symbol
    )
}

extension ISO_32000.`9`.`6`.Font.ZapfDingbats {

    public static let regular = ISO_32000.`9`.`6`.Font(
        baseFontName: .zapfDingbats,
        resourceName: .f14,
        metrics: .zapfDingbats,
        isMonospaced: false,
        weight: .regular,
        style: .normal,
        family: .zapfDingbats
    )
}

extension ISO_32000.`9`.`6`.Font {

    public static let standard14: [ISO_32000.`9`.`6`.Font] = [
        Helvetica.regular,
        Helvetica.bold,
        Helvetica.oblique,
        Helvetica.boldOblique,
        Times.regular,
        Times.bold,
        Times.italic,
        Times.boldItalic,
        Courier.regular,
        Courier.bold,
        Courier.oblique,
        Courier.boldOblique,
        Symbol.regular,
        ZapfDingbats.regular,
    ]
}

extension ISO_32000.`9`.`6`.Font {

    public func width(
        of text: String,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width {
        metrics.width(of: text, atSize: fontSize)
    }

    public var winAnsi: WinAnsi { WinAnsi(font: self) }

    public struct WinAnsi: Sendable {
        let font: ISO_32000.`9`.`6`.Font
    }
}

extension ISO_32000.`9`.`6`.Font.WinAnsi {

    public func width<Bytes: Collection>(
        of bytes: Bytes,
        atSize fontSize: ISO_32000.UserSpace.Size<1>
    ) -> ISO_32000.UserSpace.Width where Bytes.Element == Byte {
        font.metrics.winAnsi.width(of: bytes, atSize: fontSize)
    }
}

extension ISO_32000.`9`.`6`.Font {

    public static func find(
        family: Family,
        weight: Weight = .regular,
        style: Style = .normal
    ) -> ISO_32000.`9`.`6`.Font? {
        standard14.first { font in
            font.family == family && font.weight == weight && font.style == style
        }
    }

    public var bold: ISO_32000.`9`.`6`.Font {
        if weight == .bold { return self }
        return Self.find(family: family, weight: .bold, style: style) ?? self
    }

    public var italic: ISO_32000.`9`.`6`.Font {
        if style == .italic || style == .oblique { return self }
        let targetStyle: Style = (family == .times) ? .italic : .oblique
        return Self.find(family: family, weight: weight, style: targetStyle) ?? self
    }

    public var regular: ISO_32000.`9`.`6`.Font {
        Self.find(family: family, weight: .regular, style: .normal) ?? self
    }
}
