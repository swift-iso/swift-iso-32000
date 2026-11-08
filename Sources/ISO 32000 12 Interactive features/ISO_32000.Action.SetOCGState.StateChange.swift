public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.SetOCGState {
    public struct StateChange: Sendable, Hashable {

        public var command: Command

        public var ocgs: [Int]

        public init(command: Command, ocgs: [Int]) {
            self.command = command
            self.ocgs = ocgs
        }
    }
}
