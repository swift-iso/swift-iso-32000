public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct Hide: Sendable, Equatable, Hashable, Codable {

        public var target: Target

        public var hide: Bool

        public init(target: Target, hide: Bool = true) {
            self.target = target
            self.hide = hide
        }
    }
}
