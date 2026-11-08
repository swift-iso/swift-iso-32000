public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public struct ImportData: Sendable, Hashable {

        // swift-linter:disable:next raw concept
        // REASON: An ImportData action's /F, a PDF file specification string (ISO 32000 7.11.2) in PDF's own platform-independent syntax; looked at Path and File.Path, which hold this platform's paths; ISO 32000 has no file specification type of its own.
        public var file: String

        // swift-linter:disable:next raw concept
        // REASON: An ImportData action's /F, a PDF file specification string (ISO 32000 7.11.2) in PDF's own platform-independent syntax; looked at Path and File.Path, which hold this platform's paths; ISO 32000 has no file specification type of its own.
        public init(file: String) {
            self.file = file
        }
    }
}
