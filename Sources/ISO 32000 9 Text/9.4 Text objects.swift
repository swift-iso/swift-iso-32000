public import Byte
public import ISO_32000_Shared

extension ISO_32000.`9` {

    public enum `4` {}
}

extension ISO_32000.`9`.`4` {
}

extension ISO_32000.`9`.`4`.`4` {
}

extension ISO_32000 {

    public typealias TextSpace = Geometry<Double, ISO_32000.`9`.`4`.`4`.TextSpace>
}

extension ISO_32000.`9`.`4` {
}

extension ISO_32000.`9`.`4`.Matrix {

    public static let identity = Self()

    public static func translation(tx: Double, ty: Double) -> Self {
        Self(a: 1, b: 0, c: 0, d: 1, e: tx, f: ty)
    }

    public static func scaling(sx: Double, sy: Double) -> Self {
        Self(a: sx, b: 0, c: 0, d: sy, e: 0, f: 0)
    }

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

    public static func td(tx: Double, ty: Double, lineMatrix: Self) -> Self {
        .concatenating(.translation(tx: tx, ty: ty), lineMatrix)
    }

    public static func rendering(
        textMatrix: Self,
        fontSize: Double,
        horizontalScaling: Double,
        rise: Double,
        ctm: Self
    ) -> Self {
        let th = horizontalScaling / 100.0

        let fontMatrix = Self(
            a: fontSize * th,
            b: 0,
            c: 0,
            d: fontSize,
            e: 0,
            f: rise
        )

        return .concatenating(.concatenating(fontMatrix, textMatrix), ctm)
    }
}

extension ISO_32000.`9`.`4` {
}

extension ISO_32000.`9`.`4`.Displacement {

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

extension ISO_32000.`9`.`4` {
}

extension ISO_32000.Text {

    public typealias Matrix = ISO_32000.`9`.`4`.Matrix

    public typealias TJElement = ISO_32000.`9`.`4`.TJElement
}
