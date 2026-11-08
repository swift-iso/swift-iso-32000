public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.`12`.`3` {
    public enum CollectionView: String, Sendable, Hashable, Codable, CaseIterable {

        case details = "D"

        case tile = "T"

        case hidden = "H"

        case custom = "C"
    }
}
