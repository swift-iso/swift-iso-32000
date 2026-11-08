public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public struct ResetForm: Sendable, Hashable {

        public var fields: [String]?

        public var exclude: Bool

        public init(fields: [String]? = nil, exclude: Bool = false) {
            self.fields = fields
            self.exclude = exclude
        }
    }
}
