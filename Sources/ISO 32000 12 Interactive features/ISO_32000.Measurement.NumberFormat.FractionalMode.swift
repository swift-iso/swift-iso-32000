public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Measurement.NumberFormat {
    public enum FractionalMode: String, Sendable, Hashable, Codable, CaseIterable {

        case decimal = "D"

        case fraction = "F"

        case round = "R"

        case truncate = "T"
    }
}
