public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action.Transition {
    public struct TransitionDict: Sendable, Hashable {

        public var style: Style

        public var duration: Double

        public init(style: Style = .replace, duration: Double = 1) {
            self.style = style
            self.duration = duration
        }
    }
}
