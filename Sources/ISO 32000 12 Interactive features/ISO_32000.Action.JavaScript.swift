public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct JavaScript: Sendable, Equatable, Hashable, Codable {

        public var script: String

        public init(script: String) {
            self.script = script
        }
    }
}
