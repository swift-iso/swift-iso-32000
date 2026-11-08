public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation.FreeText {
    public enum Quadding: Int, Sendable, Hashable, Codable, CaseIterable {

        case leftJustified = 0

        case centered = 1

        case rightJustified = 2
    }
}
