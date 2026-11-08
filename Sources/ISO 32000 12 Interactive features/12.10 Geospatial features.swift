public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `10` {}
}

extension ISO_32000 {

    public enum Geospatial {}
}

extension ISO_32000.Geospatial {

    public struct Measure: Sendable, Hashable {

        public var bounds: [Double]?

        public var gcs: CoordinateSystem

        public var dcs: CoordinateSystem?

        public var pdu: PreferredDisplayUnits?

        public var gpts: [Double]

        public var lpts: [Double]?

        public var pcsm: [Double]?

        public init(
            bounds: [Double]? = nil,
            gcs: CoordinateSystem,
            dcs: CoordinateSystem? = nil,
            pdu: PreferredDisplayUnits? = nil,
            gpts: [Double],
            lpts: [Double]? = nil,
            pcsm: [Double]? = nil
        ) {
            self.bounds = bounds
            self.gcs = gcs
            self.dcs = dcs
            self.pdu = pdu
            self.gpts = gpts
            self.lpts = lpts
            self.pcsm = pcsm
        }
    }
}

extension ISO_32000.Geospatial.Measure {

    public struct PreferredDisplayUnits: Sendable, Hashable {
        public var linear: LinearUnit
        public var area: AreaUnit
        public var angular: AngularUnit

        public init(linear: LinearUnit, area: AreaUnit, angular: AngularUnit) {
            self.linear = linear
            self.area = area
            self.angular = angular
        }
    }

    public enum LinearUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case m = "M"

        case km = "KM"

        case ft = "FT"

        case usFoot = "USFT"

        case mile = "MI"

        case nauticalMile = "NM"
    }

    public enum AreaUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case sqm = "SQM"

        case ha = "HA"

        case sqkm = "SQKM"

        case sqft = "SQFT"

        case acre = "A"

        case sqmi = "SQMI"
    }

    public enum AngularUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case deg = "DEG"

        case grd = "GRD"
    }
}

extension ISO_32000.Geospatial {

    public enum CoordinateSystem: Sendable, Hashable {

        case geographic(Geographic)

        case projected(Projected)
    }
}

extension ISO_32000.Geospatial {

    public struct Geographic: Sendable, Hashable {

        public var reference: CoordinateReference

        public init(reference: CoordinateReference) {
            self.reference = reference
        }
    }
}

extension ISO_32000.Geospatial {

    public struct Projected: Sendable, Hashable {

        public var reference: CoordinateReference

        public init(reference: CoordinateReference) {
            self.reference = reference
        }
    }
}

extension ISO_32000.Geospatial {

    public enum CoordinateReference: Sendable, Hashable {

        case epsg(Int)

        case wkt(String)
    }
}

extension ISO_32000.Geospatial {

    public struct PointData: Sendable, Hashable {

        public var names: [PointDataName]

        public var xpts: [[PointDataValue]]

        public init(names: [PointDataName], xpts: [[PointDataValue]]) {
            self.names = names
            self.xpts = xpts
        }
    }
}

extension ISO_32000.Geospatial.PointData {

    public enum PointDataName: Sendable, Hashable {

        case lat

        case lon

        case alt

        case custom(String)
    }

    public enum PointDataValue: Sendable, Hashable {
        case number(Double)
        case string(String)
    }
}

extension ISO_32000.`12`.`10` {

    public typealias Measure = ISO_32000.Geospatial.Measure

    public typealias CoordinateSystem = ISO_32000.Geospatial.CoordinateSystem

    public typealias Geographic = ISO_32000.Geospatial.Geographic

    public typealias Projected = ISO_32000.Geospatial.Projected

    public typealias PointData = ISO_32000.Geospatial.PointData
}
