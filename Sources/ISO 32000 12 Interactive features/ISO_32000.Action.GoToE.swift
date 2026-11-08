public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct GoToE: Sendable, Hashable {

        // swift-linter:disable:next raw concept
        // REASON: A PDF file specification string (ISO 32000 7.11.2), in PDF's own platform-independent syntax, whatever machine reads the document; looked at Path and File.Path, which hold this platform's paths, and RFC_3986.URI, which it isn't; ISO 32000 has no file specification type of its own.
        public var file: String?

        public var destination: ISO_32000.Destination

        public var target: Target?

        public var newWindow: Bool?

        public init(
            destination: ISO_32000.Destination,
            // swift-linter:disable:next raw concept
            // REASON: A PDF file specification string (ISO 32000 7.11.2), in PDF's own platform-independent syntax, whatever machine reads the document; looked at Path and File.Path, which hold this platform's paths, and RFC_3986.URI, which it isn't; ISO 32000 has no file specification type of its own.
            file: String? = nil,
            target: Target? = nil,
            newWindow: Bool? = nil
        ) {
            self.destination = destination
            self.file = file
            self.target = target
            self.newWindow = newWindow
        }
    }
}
