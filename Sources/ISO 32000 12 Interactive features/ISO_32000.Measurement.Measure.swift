public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Measurement {
    public struct Measure: Sendable, Hashable {

        public var content: Content

        public init(content: Content) {
            self.content = content
        }
    }
}
