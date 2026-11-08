public import ISO_32000_Shared


extension ISO_32000.`12`.`2`.Print {
    public enum Duplex: String, Sendable, Hashable, Codable, CaseIterable {

        case simplex = "Simplex"

        case duplexFlipShortEdge = "DuplexFlipShortEdge"

        case duplexFlipLongEdge = "DuplexFlipLongEdge"
    }
}
