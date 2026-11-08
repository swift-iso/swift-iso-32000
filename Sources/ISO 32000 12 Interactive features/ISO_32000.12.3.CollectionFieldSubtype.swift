public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.`12`.`3` {
    public enum CollectionFieldSubtype: String, Sendable, Hashable, Codable, CaseIterable {

        case text = "S"

        case date = "D"

        case number = "N"

        case fileName = "F"

        case description = "Desc"

        case modificationDate = "ModDate"

        case creationDate = "CreationDate"

        case size = "Size"

        case compressedSize = "CompressedSize"
    }
}
