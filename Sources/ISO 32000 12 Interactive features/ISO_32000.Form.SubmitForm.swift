public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public struct SubmitForm: Sendable, Hashable {

        public var url: RFC_3986.URI

        public var fields: [String]?

        public var flags: SubmitOptions

        public init(url: RFC_3986.URI, fields: [String]? = nil, flags: SubmitOptions = []) {
            self.url = url
            self.fields = fields
            self.flags = flags
        }
    }
}
