public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


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
