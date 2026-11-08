public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Rendition {
    public enum Operation: Int, Sendable, Hashable, Codable, CaseIterable {

        case play = 0

        case stop = 1

        case pause = 2

        case resume = 3

        case playFromAnnotation = 4
    }
}
