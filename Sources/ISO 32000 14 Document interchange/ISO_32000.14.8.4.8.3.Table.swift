public import Binary
import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions


extension ISO_32000.`14`.`8`.`4`.`8`.`3` {
    public struct Table: Sendable, Hashable {

        public var summary: String?

        public init(summary: String? = nil) {
            self.summary = summary
        }
    }
}
