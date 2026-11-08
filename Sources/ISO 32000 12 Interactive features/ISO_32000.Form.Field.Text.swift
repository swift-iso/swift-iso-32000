public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public struct Text: Sendable, Hashable {

        public var flags: TextOptions

        public var maxLength: Int?

        public var defaultAppearance: String?

        public var quadding: ISO_32000.Form.Quadding

        public var richText: String?

        public var defaultStyle: String?

        public init(
            flags: TextOptions = [],
            maxLength: Int? = nil,
            defaultAppearance: String? = nil,
            quadding: ISO_32000.Form.Quadding = .left,
            richText: String? = nil,
            defaultStyle: String? = nil
        ) {
            self.flags = flags
            self.maxLength = maxLength
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
            self.richText = richText
            self.defaultStyle = defaultStyle
        }
    }
}
