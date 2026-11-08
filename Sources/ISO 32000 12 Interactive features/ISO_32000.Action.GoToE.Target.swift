public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.GoToE {
    public struct Target: Sendable, Hashable {

        public var relation: Relation

        public var name: String?

        public var pageNumber: Int?

        public var annotationIndex: Int?

        public var next: ISO_32000.Action.Box<Target>?

        public init(
            relation: Relation,
            name: String? = nil,
            pageNumber: Int? = nil,
            annotationIndex: Int? = nil,
            next: Target? = nil
        ) {
            self.relation = relation
            self.name = name
            self.pageNumber = pageNumber
            self.annotationIndex = annotationIndex
            self.next = next.map { ISO_32000.Action.Box($0) }
        }
    }
}
