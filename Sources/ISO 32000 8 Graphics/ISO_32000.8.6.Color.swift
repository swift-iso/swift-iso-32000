public import ISO_32000_Shared


extension ISO_32000.`8`.`6` {
    public enum Color: Sendable, Hashable {

        case gray(Double)

        case rgb(r: Double, g: Double, b: Double)

        case cmyk(c: Double, m: Double, y: Double, k: Double)
    }
}
