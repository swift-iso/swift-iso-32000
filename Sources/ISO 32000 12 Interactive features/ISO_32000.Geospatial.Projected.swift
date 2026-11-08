public import ISO_32000_Shared


extension ISO_32000.Geospatial {
    public struct Projected: Sendable, Hashable {

        public var reference: CoordinateReference

        public init(reference: CoordinateReference) {
            self.reference = reference
        }
    }
}
