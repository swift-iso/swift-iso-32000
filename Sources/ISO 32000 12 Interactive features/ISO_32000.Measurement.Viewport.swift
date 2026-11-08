public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Measurement {
    public struct Viewport: Sendable, Hashable {

        public var bbox: ISO_32000.UserSpace.Rectangle

        public var name: String?

        public var measure: Measure?

        public var ptData: Int?

        public init(
            bbox: ISO_32000.UserSpace.Rectangle,
            name: String? = nil,
            measure: Measure? = nil,
            ptData: Int? = nil
        ) {
            self.bbox = bbox
            self.name = name
            self.measure = measure
            self.ptData = ptData
        }
    }
}
