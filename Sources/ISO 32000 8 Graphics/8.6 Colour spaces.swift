public import ISO_32000_Shared

extension ISO_32000.`8` {

    public enum `6` {}
}

extension ISO_32000.`8`.`6` {

    public enum `4` {}
}

extension ISO_32000.`8`.`6`.`4` {

    public enum `2` {}

    public enum `3` {}

    public enum `4` {}
}

extension ISO_32000.`8`.`6` {

    public enum Color: Sendable, Hashable {

        case gray(Double)

        case rgb(r: Double, g: Double, b: Double)

        case cmyk(c: Double, m: Double, y: Double, k: Double)
    }
}

extension ISO_32000.`8`.`6`.Color {

    public static let black = Self.gray(0)

    public static let white = Self.gray(1)

    public static let red = Self.rgb(r: 1, g: 0, b: 0)

    public static let green = Self.rgb(r: 0, g: 1, b: 0)

    public static let blue = Self.rgb(r: 0, g: 0, b: 1)

    public static let cyan = Self.rgb(r: 0, g: 1, b: 1)

    public static let magenta = Self.rgb(r: 1, g: 0, b: 1)

    public static let yellow = Self.rgb(r: 1, g: 1, b: 0)

    public static let darkGray = Self.gray(0.25)

    public static let gray50 = Self.gray(0.5)

    public static let lightGray = Self.gray(0.75)
}

extension ISO_32000.`8`.`6`.Color {

    public init?(hex: String) {
        var hexString = hex
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        let scanner = hexString.unicodeScalars
        var value: UInt64 = 0

        for scalar in scanner {
            value *= 16
            switch scalar {
            case "0"..."9":
                value += UInt64(scalar.value - UnicodeScalar("0").value)

            case "a"..."f":
                value += UInt64(scalar.value - UnicodeScalar("a").value + 10)

            case "A"..."F":
                value += UInt64(scalar.value - UnicodeScalar("A").value + 10)

            default:
                return nil
            }
        }

        switch hexString.count {
        case 3:

            let r = Double((value >> 8) & 0xF) / 15.0
            let g = Double((value >> 4) & 0xF) / 15.0
            let b = Double(value & 0xF) / 15.0
            self = .rgb(r: r, g: g, b: b)

        case 6:

            let r = Double((value >> 16) & 0xFF) / 255.0
            let g = Double((value >> 8) & 0xFF) / 255.0
            let b = Double(value & 0xFF) / 255.0
            self = .rgb(r: r, g: g, b: b)

        default:
            return nil
        }
    }
}

extension ISO_32000.`8`.`6`.Color {

    public var colorSpaceName: String {
        switch self {
        case .gray:
            return "DeviceGray"

        case .rgb:
            return "DeviceRGB"

        case .cmyk:
            return "DeviceCMYK"
        }
    }

    public var componentCount: Int {
        switch self {
        case .gray:
            return 1

        case .rgb:
            return 3

        case .cmyk:
            return 4
        }
    }

    public var components: [Double] {
        switch self {
        case .gray(let g):
            return [g]

        case .rgb(let r, let g, let b):
            return [r, g, b]

        case .cmyk(let c, let m, let y, let k):
            return [c, m, y, k]
        }
    }
}

extension ISO_32000.`8`.`6`.Color {

    public var toGray: Self {
        switch self {
        case .gray:
            return self

        case .rgb(let r, let g, let b):
            let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
            return .gray(luminance)

        case .cmyk(let c, let m, let y, let k):

            let r = (1 - c) * (1 - k)
            let g = (1 - m) * (1 - k)
            let b = (1 - y) * (1 - k)
            let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
            return .gray(luminance)
        }
    }

    public var toRGB: Self {
        switch self {
        case .gray(let g):
            return .rgb(r: g, g: g, b: g)

        case .rgb:
            return self

        case .cmyk(let c, let m, let y, let k):
            let r = (1 - c) * (1 - k)
            let g = (1 - m) * (1 - k)
            let b = (1 - y) * (1 - k)
            return .rgb(r: r, g: g, b: b)
        }
    }
}
