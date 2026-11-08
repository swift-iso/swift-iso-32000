public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5` {
    public struct Border: Sendable, Hashable {

        public var horizontalRadius: Double

        public var verticalRadius: Double

        public var width: Double

        public var dashArray: [Double]?

        public init(
            horizontalRadius: Double = 0,
            verticalRadius: Double = 0,
            width: Double = 1,
            dashArray: [Double]? = nil
        ) {
            self.horizontalRadius = horizontalRadius
            self.verticalRadius = verticalRadius
            self.width = width
            self.dashArray = dashArray
        }
    }
}
