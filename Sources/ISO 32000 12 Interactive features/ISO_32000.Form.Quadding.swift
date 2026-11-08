public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public enum Quadding: Int, Sendable, Hashable, Codable, CaseIterable {

        case left = 0

        case center = 1

        case right = 2
    }
}
