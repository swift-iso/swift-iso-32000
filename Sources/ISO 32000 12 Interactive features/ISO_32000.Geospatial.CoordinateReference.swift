public import ISO_32000_Shared


extension ISO_32000.Geospatial {
    public enum CoordinateReference: Sendable, Hashable {

        case epsg(Int)

        case wkt(String)
    }
}
