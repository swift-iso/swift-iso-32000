public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Choice {
    public struct Option: Sendable, Hashable {

        public var exportValue: String

        public var displayValue: String

        public init(exportValue: String, displayValue: String? = nil) {
            self.exportValue = exportValue
            self.displayValue = displayValue ?? exportValue
        }
    }
}
