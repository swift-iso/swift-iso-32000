public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Transition {
    public struct Effect: Sendable {

        public var style: Style

        public var duration: Double

        public var dimension: Dimension?

        public var motion: Motion?

        public var direction: Direction?

        public var scale: Double?

        public var opaque: Bool?

        public init(
            style: Style = .replace,
            duration: Double = 1.0,
            dimension: Dimension? = nil,
            motion: Motion? = nil,
            direction: Direction? = nil,
            scale: Double? = nil,
            opaque: Bool? = nil
        ) {
            self.style = style
            self.duration = duration
            self.dimension = dimension
            self.motion = motion
            self.direction = direction
            self.scale = scale
            self.opaque = opaque
        }
    }
}
