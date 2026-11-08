public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5` {
    public struct Appearance: Sendable, Hashable {

        public var normal: Entry

        public var rollover: Entry?

        public var down: Entry?

        public init(
            normal: Entry,
            rollover: Entry? = nil,
            down: Entry? = nil
        ) {
            self.normal = normal
            self.rollover = rollover
            self.down = down
        }
    }
}
