public import ISO_32000_Shared


extension ISO_32000.`12`.`2`.Viewer {
    public struct Print: Sendable, Hashable, Codable {

        public var area: ISO_32000.`12`.`2`.Boundary

        public var clip: ISO_32000.`12`.`2`.Boundary

        public var scaling: ISO_32000.`12`.`2`.Print.Scaling

        public var duplex: ISO_32000.`12`.`2`.Print.Duplex?

        public var pickTrayByPDFSize: Bool?

        public var pageRange: [ISO_32000.`12`.`2`.PageRange]?

        public var numCopies: Int?

        public init(
            area: ISO_32000.`12`.`2`.Boundary = .cropBox,
            clip: ISO_32000.`12`.`2`.Boundary = .cropBox,
            scaling: ISO_32000.`12`.`2`.Print.Scaling = .appDefault,
            duplex: ISO_32000.`12`.`2`.Print.Duplex? = nil,
            pickTrayByPDFSize: Bool? = nil,
            pageRange: [ISO_32000.`12`.`2`.PageRange]? = nil,
            numCopies: Int? = nil
        ) {
            self.area = area
            self.clip = clip
            self.scaling = scaling
            self.duplex = duplex
            self.pickTrayByPDFSize = pickTrayByPDFSize
            self.pageRange = pageRange
            self.numCopies = numCopies
        }
    }
}
