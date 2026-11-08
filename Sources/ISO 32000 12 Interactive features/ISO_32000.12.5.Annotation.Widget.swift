public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.`12`.`5`.Annotation {
    public struct Widget: Sendable, Hashable {

        public var highlightMode: HighlightMode

        public var appearanceCharacteristics: AppearanceCharacteristics?

        public var action: Int?

        public var additionalActions: Int?

        public var borderStyle: ISO_32000.`12`.`5`.Border.Style?

        public init(
            highlightMode: HighlightMode = .invert,
            appearanceCharacteristics: AppearanceCharacteristics? = nil,
            action: Int? = nil,
            additionalActions: Int? = nil,
            borderStyle: ISO_32000.`12`.`5`.Border.Style? = nil
        ) {
            self.highlightMode = highlightMode
            self.appearanceCharacteristics = appearanceCharacteristics
            self.action = action
            self.additionalActions = additionalActions
            self.borderStyle = borderStyle
        }
    }
}
