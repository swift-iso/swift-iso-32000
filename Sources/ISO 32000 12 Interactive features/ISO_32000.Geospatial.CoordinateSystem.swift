public import ISO_32000_Shared


extension ISO_32000.Geospatial {
    public enum CoordinateSystem: Sendable, Hashable {

        case geographic(Geographic)

        case projected(Projected)
    }
}
