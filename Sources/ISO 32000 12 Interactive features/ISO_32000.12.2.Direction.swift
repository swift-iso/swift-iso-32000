public import ISO_32000_Shared


extension ISO_32000.`12`.`2` {
    public enum Direction: String, Sendable, Hashable, Codable, CaseIterable {

        case leftToRight = "L2R"

        case rightToLeft = "R2L"
    }
}
