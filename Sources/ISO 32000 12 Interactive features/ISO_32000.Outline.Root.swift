public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Outline {
    public struct Root: Sendable {

        public var items: [Item]

        public init(items: [Item] = []) {
            self.items = items
        }
    }
}
