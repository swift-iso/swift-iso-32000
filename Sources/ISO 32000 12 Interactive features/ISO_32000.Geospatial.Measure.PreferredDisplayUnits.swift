public import ISO_32000_Shared


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
}
