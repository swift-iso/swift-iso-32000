public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct Transition: Sendable, Hashable {

        public var trans: TransitionDict

        public init(trans: TransitionDict) {
            self.trans = trans
        }
    }
}
