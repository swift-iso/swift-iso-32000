import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import Space


extension ISO_32000.Text.Rendering {
    public enum Mode: Int, Sendable, Equatable, Hashable, Codable, CaseIterable {

        case fill = 0

        case stroke = 1

        case fillStroke = 2

        case invisible = 3

        case fillClip = 4

        case strokeClip = 5

        case fillStrokeClip = 6

        case clip = 7
    }
}
