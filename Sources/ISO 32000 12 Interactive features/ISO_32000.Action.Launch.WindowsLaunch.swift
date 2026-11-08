public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Launch {
    public struct WindowsLaunch: Sendable, Hashable {

        // swift-linter:disable:next raw concept
        // REASON: A Launch action's /F, a byte string in DOS syntax for a Windows viewer, whatever platform reads the PDF; looked at Path and File.Path, which hold this platform's paths.
        public var file: String

        // swift-linter:disable:next raw concept
        // REASON: A Launch action's /D, a byte string in DOS syntax for a Windows viewer, whatever platform reads the PDF; looked at Path and File.Directory, which hold this platform's paths.
        public var directory: String?

        public var operation: Operation?

        public var parameters: String?

        public init(
            // swift-linter:disable:next raw concept
            // REASON: A Launch action's /F, a byte string in DOS syntax for a Windows viewer, whatever platform reads the PDF; looked at Path and File.Path, which hold this platform's paths.
            file: String,
            // swift-linter:disable:next raw concept
            // REASON: A Launch action's /D, a byte string in DOS syntax for a Windows viewer, whatever platform reads the PDF; looked at Path and File.Directory, which hold this platform's paths.
            directory: String? = nil,
            operation: Operation? = nil,
            parameters: String? = nil
        ) {
            self.file = file
            self.directory = directory
            self.operation = operation
            self.parameters = parameters
        }
    }
}
