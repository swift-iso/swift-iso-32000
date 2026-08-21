public import Geometry_Primitives
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `9` {}
}

extension ISO_32000 {

    public enum Measurement {}
}

extension ISO_32000.Measurement {

    public struct Viewport: Sendable, Hashable {

        public var bbox: ISO_32000.UserSpace.Rectangle

        public var name: String?

        public var measure: Measure?

        public var ptData: Int?

        public init(
            bbox: ISO_32000.UserSpace.Rectangle,
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

extension ISO_32000.Measurement {

    public struct Measure: Sendable, Hashable {

        public var content: Content

        public init(content: Content) {
            self.content = content
        }
    }
}

extension ISO_32000.Measurement.Measure {

    public enum Content: Sendable, Hashable {

        case rectilinear(Rectilinear)

        case geospatial(Geospatial)
    }
}

extension ISO_32000.Measurement.Measure {

    public struct Rectilinear: Sendable, Hashable {

        public var scaleRatio: String

        public var x: [ISO_32000.Measurement.NumberFormat]

        public var y: [ISO_32000.Measurement.NumberFormat]?

        public var distance: [ISO_32000.Measurement.NumberFormat]

        public var area: [ISO_32000.Measurement.NumberFormat]

        public var angle: [ISO_32000.Measurement.NumberFormat]?

        public var slope: [ISO_32000.Measurement.NumberFormat]?

        public var origin: Origin?

        public var cyx: Double?

        public init(
            scaleRatio: String,
            x: [ISO_32000.Measurement.NumberFormat],
            y: [ISO_32000.Measurement.NumberFormat]? = nil,
            distance: [ISO_32000.Measurement.NumberFormat],
            area: [ISO_32000.Measurement.NumberFormat],
            angle: [ISO_32000.Measurement.NumberFormat]? = nil,
            slope: [ISO_32000.Measurement.NumberFormat]? = nil,
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

extension ISO_32000.Measurement.Measure.Rectilinear {

    public struct Origin: Sendable, Hashable {
        public var x: Double
        public var y: Double

        public init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
    }
}

extension ISO_32000.Measurement.Measure {

    public struct Geospatial: Sendable, Hashable {

        public var geoMeasure: ISO_32000.Geospatial.Measure?

        public init(geoMeasure: ISO_32000.Geospatial.Measure? = nil) {
            self.geoMeasure = geoMeasure
        }
    }
}

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

extension ISO_32000.Measurement.NumberFormat {

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

extension ISO_32000.`12`.`9` {

    public typealias Viewport = ISO_32000.Measurement.Viewport

    public typealias Measure = ISO_32000.Measurement.Measure

    public typealias NumberFormat = ISO_32000.Measurement.NumberFormat
}
