public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Measurement {
    public struct NumberFormat: Sendable, Hashable {

        public var unitLabel: String

        public var conversionFactor: Double

        public var fractionalMode: FractionalMode?

        public var precision: Int?

        public var fixedDenominator: Bool?

        public var thousandsSeparator: String?

        public var decimalSeparator: String?

        public var prefixSeparator: String?

        public var suffixSeparator: String?

        public var labelPosition: LabelPosition?

        public init(
            unitLabel: String,
            conversionFactor: Double,
            fractionalMode: FractionalMode? = nil,
            precision: Int? = nil,
            fixedDenominator: Bool? = nil,
            thousandsSeparator: String? = nil,
            decimalSeparator: String? = nil,
            prefixSeparator: String? = nil,
            suffixSeparator: String? = nil,
            labelPosition: LabelPosition? = nil
        ) {
            self.unitLabel = unitLabel
            self.conversionFactor = conversionFactor
            self.fractionalMode = fractionalMode
            self.precision = precision
            self.fixedDenominator = fixedDenominator
            self.thousandsSeparator = thousandsSeparator
            self.decimalSeparator = decimalSeparator
            self.prefixSeparator = prefixSeparator
            self.suffixSeparator = suffixSeparator
            self.labelPosition = labelPosition
        }
    }
}
