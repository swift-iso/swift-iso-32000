public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.RichMediaExecute {
    public struct Command: Sendable, Hashable {

        public var type: CommandType

        public var name: String?

        public var argument: String?

        public init(type: CommandType, name: String? = nil, argument: String? = nil) {
            self.type = type
            self.name = name
            self.argument = argument
        }
    }
}
