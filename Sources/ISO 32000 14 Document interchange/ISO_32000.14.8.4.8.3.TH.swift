public import Binary
import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions


extension ISO_32000.`14`.`8`.`4`.`8`.`3` {
    public struct TH: Sendable, Hashable {

        public var row: TH.Row

        public var col: TH.Col

        public var headers: [String]

        public var scope: TH.Scope?

        public var short: String?

        public init(
            row: TH.Row = Row(),
            col: TH.Col = Col(),
            headers: [String] = [],
            scope: TH.Scope? = nil,
            short: String? = nil
        ) {
            self.row = row
            self.col = col
            self.headers = headers
            self.scope = scope
            self.short = short
        }
    }
}
