public import ISO_32000_Shared


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
