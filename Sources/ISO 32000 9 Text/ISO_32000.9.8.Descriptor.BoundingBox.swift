public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.`9`.`8`.Descriptor {
    public struct BoundingBox: Sendable, Equatable {

        public let llx: Int

        public let lly: Int

        public let urx: Int

        public let ury: Int

        public init(llx: Int, lly: Int, urx: Int, ury: Int) {
            self.llx = llx
            self.lly = lly
            self.urx = urx
            self.ury = ury
        }
    }
}
