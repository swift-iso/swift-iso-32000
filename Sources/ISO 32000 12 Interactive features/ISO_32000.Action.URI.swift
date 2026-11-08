public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct URI: Sendable, Equatable, Hashable {

        public var uri: RFC_3986.URI

        public var isMap: Bool

        public init(uri: RFC_3986.URI, isMap: Bool = false) {
            self.uri = uri
            self.isMap = isMap
        }
    }
}
