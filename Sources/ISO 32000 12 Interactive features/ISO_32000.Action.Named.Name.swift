public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Named {
    public enum Name: String, Sendable, Codable, CaseIterable {

        case nextPage = "NextPage"

        case prevPage = "PrevPage"

        case firstPage = "FirstPage"

        case lastPage = "LastPage"
    }
}
