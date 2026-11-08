public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct RichMediaExecute: Sendable, Hashable {

        public var annotation: Int

        public var command: Command

        public init(annotation: Int, command: Command) {
            self.annotation = annotation
            self.command = command
        }
    }
}
