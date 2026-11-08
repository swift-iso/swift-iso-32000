public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Article {
    public struct Thread: Sendable {

        public var beads: [Bead]

        public var info: Info?

        public init(beads: [Bead] = [], info: Info? = nil) {
            self.beads = beads
            self.info = info
        }
    }
}
