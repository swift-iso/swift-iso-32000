public import ISO_32000_Shared


extension ISO_32000.Geospatial.Measure {
    public enum AreaUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case sqm = "SQM"

        case ha = "HA"

        case sqkm = "SQKM"

        case sqft = "SQFT"

        case acre = "A"

        case sqmi = "SQMI"
    }
}
