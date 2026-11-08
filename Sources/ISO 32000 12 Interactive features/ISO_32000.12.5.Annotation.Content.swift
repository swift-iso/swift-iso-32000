public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public enum Content: Sendable, Hashable {

        case link(Link)

        case text(Text)

        case freeText(FreeText)

        case line(Line)

        case shape(Shape)

        case poly(Poly)

        case textMarkup(TextMarkup)

        case caret(Caret)

        case stamp(Stamp)

        case ink(Ink)

        case popup(Popup)

        case fileAttachment(FileAttachment)

        case redaction(Redaction)

        case widget(Widget)
    }
}
