public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation.Link {
    public enum Target: Sendable, Hashable {

        case uri(RFC_3986.URI)

        case destination(ISO_32000.Destination)
    }
}
