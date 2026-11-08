public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation.Text {
    public enum IconName: String, Sendable, Hashable, Codable, CaseIterable {
        case comment = "Comment"
        case key = "Key"
        case note = "Note"
        case help = "Help"
        case newParagraph = "NewParagraph"
        case paragraph = "Paragraph"
        case insert = "Insert"
    }
}
