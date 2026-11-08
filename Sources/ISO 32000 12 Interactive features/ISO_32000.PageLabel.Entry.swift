public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.PageLabel {
    public struct Entry: Sendable, Equatable, Hashable, Codable {

        public var style: Style?

        public var prefix: String?

        public var start: Int

        public init(
            style: Style? = nil,
            prefix: String? = nil,
            start: Int = 1
        ) {
            self.style = style
            self.prefix = prefix
            self.start = start
        }
    }
}
