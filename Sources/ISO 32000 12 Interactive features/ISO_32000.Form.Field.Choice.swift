public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public struct Choice: Sendable, Hashable {

        public var flags: ChoiceOptions

        public var options: [Option]

        public var topIndex: Int?

        public var defaultAppearance: String?

        public var quadding: ISO_32000.Form.Quadding

        public init(
            flags: ChoiceOptions = [],
            options: [Option] = [],
            topIndex: Int? = nil,
            defaultAppearance: String? = nil,
            quadding: ISO_32000.Form.Quadding = .left
        ) {
            self.flags = flags
            self.options = options
            self.topIndex = topIndex
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
        }
    }
}
