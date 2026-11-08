public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct Named: Sendable, Equatable, Hashable, Codable {

        public var name: Name

        public init(name: Name) {
            self.name = name
        }
    }
}
