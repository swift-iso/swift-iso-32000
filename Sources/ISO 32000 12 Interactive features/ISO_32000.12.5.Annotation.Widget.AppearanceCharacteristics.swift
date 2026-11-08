public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.`12`.`5`.Annotation.Widget {
    public struct AppearanceCharacteristics: Sendable, Hashable {

        public var rotation: Int

        public var borderColor: ISO_32000.`12`.`5`.Annotation.Color?

        public var backgroundColor: ISO_32000.`12`.`5`.Annotation.Color?

        public var normalCaption: String?

        public var rolloverCaption: String?

        public var alternateCaption: String?

        public var normalIcon: Int?

        public var rolloverIcon: Int?

        public var alternateIcon: Int?

        public var iconFit: ISO_32000.Form.Field.Button.IconFit?

        public var textPosition: ISO_32000.Form.Field.Button.TextPosition

        public init(
            rotation: Int = 0,
            borderColor: ISO_32000.`12`.`5`.Annotation.Color? = nil,
            backgroundColor: ISO_32000.`12`.`5`.Annotation.Color? = nil,
            normalCaption: String? = nil,
            rolloverCaption: String? = nil,
            alternateCaption: String? = nil,
            normalIcon: Int? = nil,
            rolloverIcon: Int? = nil,
            alternateIcon: Int? = nil,
            iconFit: ISO_32000.Form.Field.Button.IconFit? = nil,
            textPosition: ISO_32000.Form.Field.Button.TextPosition = .captionOnly
        ) {
            self.rotation = rotation
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.normalCaption = normalCaption
            self.rolloverCaption = rolloverCaption
            self.alternateCaption = alternateCaption
            self.normalIcon = normalIcon
            self.rolloverIcon = rolloverIcon
            self.alternateIcon = alternateIcon
            self.iconFit = iconFit
            self.textPosition = textPosition
        }
    }
}
