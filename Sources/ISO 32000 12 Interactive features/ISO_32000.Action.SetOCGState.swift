public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct SetOCGState: Sendable, Hashable {

        public var state: [StateChange]

        public var preserveRB: Bool

        public init(state: [StateChange], preserveRB: Bool = true) {
            self.state = state
            self.preserveRB = preserveRB
        }
    }
}
