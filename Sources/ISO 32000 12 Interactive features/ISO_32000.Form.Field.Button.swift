public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public struct Button: Sendable, Hashable {

        public var flags: ButtonOptions

        public var normalCaption: String?

        public var rolloverCaption: String?

        public var downCaption: String?

        public var normalIcon: Int?

        public var rolloverIcon: Int?

        public var downIcon: Int?

        public var iconFit: IconFit?

        public var textPosition: TextPosition

        public var options: [String]?

        public init(
            flags: ButtonOptions = [],
            normalCaption: String? = nil,
            rolloverCaption: String? = nil,
            downCaption: String? = nil,
            normalIcon: Int? = nil,
            rolloverIcon: Int? = nil,
            downIcon: Int? = nil,
            iconFit: IconFit? = nil,
            textPosition: TextPosition = .captionOnly,
            options: [String]? = nil
        ) {
            self.flags = flags
            self.normalCaption = normalCaption
            self.rolloverCaption = rolloverCaption
            self.downCaption = downCaption
            self.normalIcon = normalIcon
            self.rolloverIcon = rolloverIcon
            self.downIcon = downIcon
            self.iconFit = iconFit
            self.textPosition = textPosition
            self.options = options
        }
    }
}
