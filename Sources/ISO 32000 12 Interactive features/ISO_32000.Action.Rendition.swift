public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct Rendition: Sendable, Hashable {

        public var operation: Operation?

        public var annotation: Int?

        public var rendition: Int?

        public var javaScript: String?

        public init(
            operation: Operation? = nil,
            annotation: Int? = nil,
            rendition: Int? = nil,
            javaScript: String? = nil
        ) {
            self.operation = operation
            self.annotation = annotation
            self.rendition = rendition
            self.javaScript = javaScript
        }
    }
}
