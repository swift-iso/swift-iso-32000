public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct FormFieldTriggers: Sendable, Hashable {

        public var keystroke: JavaScript?

        public var format: JavaScript?

        public var validate: JavaScript?

        public var calculate: JavaScript?

        public init(
            keystroke: JavaScript? = nil,
            format: JavaScript? = nil,
            validate: JavaScript? = nil,
            calculate: JavaScript? = nil
        ) {
            self.keystroke = keystroke
            self.format = format
            self.validate = validate
            self.calculate = calculate
        }
    }
}
