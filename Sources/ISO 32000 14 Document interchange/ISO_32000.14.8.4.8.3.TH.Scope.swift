public import Binary
import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions


extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH {
    public enum Scope: String, Sendable, Codable, Hashable, CaseIterable {
        case row = "Row"
        case column = "Column"
        case both = "Both"
    }
}
