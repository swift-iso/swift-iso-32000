public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO.`32000`.`12` {

    public enum `9` {}
}

extension ISO.`32000` {

    public enum Measurement {}
}

extension ISO.`32000`.Measurement {

    public struct Viewport: Sendable, Hashable {

        public var bbox: ISO.`32000`.UserSpace.Rectangle

        public var name: String?

        public var measure: Measure?

        public var ptData: Int?

        public init(
            bbox: ISO.`32000`.UserSpace.Rectangle,
            name: String? = nil,
            measure: Measure? = nil,
            ptData: Int? = nil
        ) {
            self.bbox = bbox
            self.name = name
            self.measure = measure
            self.ptData = ptData
        }
    }
}

extension ISO.`32000`.Measurement {

    public struct Measure: Sendable, Hashable {

        public var content: Content

        public init(content: Content) {
            self.content = content
        }
    }
}

extension ISO.`32000`.Measurement.Measure {

    public enum Content: Sendable, Hashable {

        case rectilinear(Rectilinear)

        case geospatial(Geospatial)
    }
}

extension ISO.`32000`.Measurement.Measure {

    public struct Rectilinear: Sendable, Hashable {

        public var scaleRatio: String

        public var x: [ISO.`32000`.Measurement.NumberFormat]

        public var y: [ISO.`32000`.Measurement.NumberFormat]?

        public var distance: [ISO.`32000`.Measurement.NumberFormat]

        public var area: [ISO.`32000`.Measurement.NumberFormat]

        public var angle: [ISO.`32000`.Measurement.NumberFormat]?

        public var slope: [ISO.`32000`.Measurement.NumberFormat]?

        public var origin: Origin?

        public var cyx: Double?

        public init(
            scaleRatio: String,
            x: [ISO.`32000`.Measurement.NumberFormat],
            y: [ISO.`32000`.Measurement.NumberFormat]? = nil,
            distance: [ISO.`32000`.Measurement.NumberFormat],
            area: [ISO.`32000`.Measurement.NumberFormat],
            angle: [ISO.`32000`.Measurement.NumberFormat]? = nil,
            slope: [ISO.`32000`.Measurement.NumberFormat]? = nil,
            origin: Origin? = nil,
            cyx: Double? = nil
        ) {
            self.scaleRatio = scaleRatio
            self.x = x
            self.y = y
            self.distance = distance
            self.area = area
            self.angle = angle
            self.slope = slope
            self.origin = origin
            self.cyx = cyx
        }
    }
}

extension ISO.`32000`.Measurement.Measure.Rectilinear {

    public struct Origin: Sendable, Hashable {
        public var x: Double
        public var y: Double

        public init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
    }
}

extension ISO.`32000`.Measurement.Measure {

    public struct Geospatial: Sendable, Hashable {

        public var geoMeasure: ISO.`32000`.Geospatial.Measure?

        public init(geoMeasure: ISO.`32000`.Geospatial.Measure? = nil) {
            self.geoMeasure = geoMeasure
        }
    }
}

extension ISO.`32000`.Measurement {

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

extension ISO.`32000`.Measurement.NumberFormat {

    public enum FractionalMode: String, Sendable, Hashable, Codable, CaseIterable {

        case decimal = "D"

        case fraction = "F"

        case round = "R"

        case truncate = "T"
    }

    public enum LabelPosition: String, Sendable, Hashable, Codable, CaseIterable {

        case suffix = "S"

        case prefix = "P"
    }
}

extension ISO.`32000`.`12`.`9` {

    public typealias Viewport = ISO.`32000`.Measurement.Viewport

    public typealias Measure = ISO.`32000`.Measurement.Measure

    public typealias NumberFormat = ISO.`32000`.Measurement.NumberFormat
}
