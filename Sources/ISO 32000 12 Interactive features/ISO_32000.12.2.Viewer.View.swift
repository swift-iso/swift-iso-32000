public import ISO_32000_Shared


extension ISO_32000.`12`.`2`.Viewer {
    public struct View: Sendable, Hashable, Codable {

        public var area: ISO_32000.`12`.`2`.Boundary

        public var clip: ISO_32000.`12`.`2`.Boundary

        public init(
            area: ISO_32000.`12`.`2`.Boundary = .cropBox,
            clip: ISO_32000.`12`.`2`.Boundary = .cropBox
        ) {
            self.area = area
            self.clip = clip
        }
    }
}
