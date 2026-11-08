public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public enum Subtype: String, Sendable, Hashable, Codable, CaseIterable {

        case text = "Text"

        case link = "Link"

        case freeText = "FreeText"

        case line = "Line"

        case square = "Square"

        case circle = "Circle"

        case polygon = "Polygon"

        case polyLine = "PolyLine"

        case highlight = "Highlight"

        case underline = "Underline"

        case squiggly = "Squiggly"

        case strikeOut = "StrikeOut"

        case caret = "Caret"

        case stamp = "Stamp"

        case ink = "Ink"

        case popup = "Popup"

        case fileAttachment = "FileAttachment"

        case sound = "Sound"

        case movie = "Movie"

        case screen = "Screen"

        case widget = "Widget"

        case printerMark = "PrinterMark"

        case trapNet = "TrapNet"

        case watermark = "Watermark"

        case threeD = "3D"

        case redact = "Redact"

        case projection = "Projection"

        case richMedia = "RichMedia"
    }
}
