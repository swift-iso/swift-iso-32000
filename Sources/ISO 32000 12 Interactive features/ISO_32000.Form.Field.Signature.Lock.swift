public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Signature {
    public struct Lock: Sendable, Hashable {

        public var action: Action

        public var fields: [String]?

        public init(action: Action, fields: [String]? = nil) {
            self.action = action
            self.fields = fields
        }
    }
}
