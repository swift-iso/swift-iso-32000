public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.SubmitForm {
    public struct SubmitOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
