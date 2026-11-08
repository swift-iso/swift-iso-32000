public import Binary
import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions


extension ISO_32000.`14`.`8`.`4`.`8`.`3` {
    public struct TD: Sendable, Hashable {

        public var row: Row

        public var col: Col

        public var headers: [String]

        public init(
            row: Row = Row(),
            col: Col = Col(),
            headers: [String] = []
        ) {
            self.row = row
            self.col = col
            self.headers = headers
        }
    }
}
