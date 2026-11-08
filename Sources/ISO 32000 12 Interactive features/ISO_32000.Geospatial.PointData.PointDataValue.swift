public import ISO_32000_Shared


extension ISO_32000.Geospatial.PointData {
    public enum PointDataValue: Sendable, Hashable {
        case number(Double)
        case string(String)
    }
}
