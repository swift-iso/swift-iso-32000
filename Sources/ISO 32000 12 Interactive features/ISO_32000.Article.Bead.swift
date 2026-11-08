public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Article {
    public struct Bead: Sendable {

        public var pageIndex: Int

        public var rect: ISO_32000.UserSpace.Rectangle

        public init(pageIndex: Int, rect: ISO_32000.UserSpace.Rectangle) {
            self.pageIndex = pageIndex
            self.rect = rect
        }
    }
}
