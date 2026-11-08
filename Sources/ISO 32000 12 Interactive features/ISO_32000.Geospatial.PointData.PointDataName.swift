public import ISO_32000_Shared


extension ISO_32000.Geospatial.PointData {
    public enum PointDataName: Sendable, Hashable {

        case lat

        case lon

        case alt

        case custom(String)
    }
}
