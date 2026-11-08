public import ISO_32000_Shared


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
