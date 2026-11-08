public import ISO_32000_Shared


extension ISO_32000.`12`.`2`.Print {
    public enum Scaling: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "None"

        case appDefault = "AppDefault"
    }
}
