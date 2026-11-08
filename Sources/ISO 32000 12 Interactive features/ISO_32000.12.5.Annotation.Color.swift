public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public enum Color: Sendable, Hashable {

        case transparent

        case gray(Double)

        case rgb(red: Double, green: Double, blue: Double)

        case cmyk(cyan: Double, magenta: Double, yellow: Double, black: Double)
    }
}
