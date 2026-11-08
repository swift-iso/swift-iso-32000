public import ISO_32000_Shared


extension ISO_32000.`12`.`2` {
    public enum NonFullScreenPageMode: String, Sendable, Hashable, Codable, CaseIterable {

        case useNone = "UseNone"

        case useOutlines = "UseOutlines"

        case useThumbs = "UseThumbs"

        case useOC = "UseOC"
    }
}
