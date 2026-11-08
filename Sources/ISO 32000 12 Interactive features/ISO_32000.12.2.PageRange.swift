public import ISO_32000_Shared


extension ISO_32000.`12`.`2` {
    public struct PageRange: Sendable, Hashable, Codable {

        public var first: Int

        public var last: Int

        public init(first: Int, last: Int) {
            self.first = first
            self.last = last
        }

        public init(page: Int) {
            self.first = page
            self.last = page
        }
    }
}
