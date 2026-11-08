public import Binary
import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions


extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH {
    public struct Row: Sendable, Hashable {

        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }
}
