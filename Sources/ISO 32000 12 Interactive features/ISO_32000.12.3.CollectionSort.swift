public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.`12`.`3` {
    public struct CollectionSort: Sendable {

        public var fields: [String]

        public var ascending: [Bool]

        public init(fields: [String], ascending: [Bool] = [true]) {
            self.fields = fields
            self.ascending = ascending
        }
    }
}
