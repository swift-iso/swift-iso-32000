public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Navigation {
    public struct Node: Sendable {

        public var nextAction: ISO_32000.Action.GoTo?

        public var previousAction: ISO_32000.Action.GoTo?

        public var duration: Double?

        public init(
            nextAction: ISO_32000.Action.GoTo? = nil,
            previousAction: ISO_32000.Action.GoTo? = nil,
            duration: Double? = nil
        ) {
            self.nextAction = nextAction
            self.previousAction = previousAction
            self.duration = duration
        }
    }
}
