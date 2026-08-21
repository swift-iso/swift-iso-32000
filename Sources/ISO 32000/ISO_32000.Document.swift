extension ISO_32000 {

    public struct Document: Sendable {

        public var version: Version

        public var info: Info?

        public var pages: [Page]

        public var outline: Outline.Root?

        public var viewer: Viewer?

        public init(
            version: Version = .default,
            info: Info? = nil,
            pages: [Page] = [],
            outline: Outline.Root? = nil,
            viewer: Viewer? = nil
        ) {
            self.version = version
            self.info = info
            self.pages = pages
            self.outline = outline
            self.viewer = viewer
        }
    }
}
