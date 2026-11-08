public import ISO_32000_Shared


extension ISO_32000.Geospatial.Measure {
    public enum LinearUnit: String, Sendable, Hashable, Codable, CaseIterable {

        case m = "M"

        case km = "KM"

        case ft = "FT"

        case usFoot = "USFT"

        case mile = "MI"

        case nauticalMile = "NM"
    }
}
