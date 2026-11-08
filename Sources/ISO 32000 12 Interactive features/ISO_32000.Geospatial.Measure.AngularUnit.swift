public import ISO_32000_Shared


extension ISO_32000.Geospatial.Measure {
    public enum AngularUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case deg = "DEG"

        case grd = "GRD"
    }
}
