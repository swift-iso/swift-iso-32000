public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public struct Field: Sendable, Hashable {

        public var parent: Int?

        public var kids: [Int]?

        public var fieldType: FieldType?

        public var partialName: String?

        public var alternateName: String?

        public var mappingName: String?

        public var flags: FieldOptions

        public var value: FieldValue?

        public var defaultValue: FieldValue?

        public var additionalActions: Int?

        public var content: Content

        public init(
            parent: Int? = nil,
            kids: [Int]? = nil,
            fieldType: FieldType? = nil,
            partialName: String? = nil,
            alternateName: String? = nil,
            mappingName: String? = nil,
            flags: FieldOptions = [],
            value: FieldValue? = nil,
            defaultValue: FieldValue? = nil,
            additionalActions: Int? = nil,
            content: Content
        ) {
            self.parent = parent
            self.kids = kids
            self.fieldType = fieldType
            self.partialName = partialName
            self.alternateName = alternateName
            self.mappingName = mappingName
            self.flags = flags
            self.value = value
            self.defaultValue = defaultValue
            self.additionalActions = additionalActions
            self.content = content
        }
    }
}
