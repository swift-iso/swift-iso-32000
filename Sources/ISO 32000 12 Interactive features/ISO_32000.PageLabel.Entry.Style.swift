public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.PageLabel.Entry {
    public enum Style: String, Sendable, Codable, CaseIterable {

        case decimal = "D"

        case romanUpper = "R"

        case romanLower = "r"

        case letterUpper = "A"

        case letterLower = "a"
    }
}
