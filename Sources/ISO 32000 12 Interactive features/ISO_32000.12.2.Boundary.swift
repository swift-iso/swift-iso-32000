public import ISO_32000_Shared


extension ISO_32000.`12`.`2` {
    public enum Boundary: String, Sendable, Hashable, Codable, CaseIterable {

        case mediaBox = "MediaBox"

        case cropBox = "CropBox"

        case bleedBox = "BleedBox"

        case trimBox = "TrimBox"

        case artBox = "ArtBox"
    }
}
