public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Border {
    public struct Style: Sendable, Hashable {

        public var width: Double

        public var style: Kind

        public var dashArray: [Double]?

        public init(
            width: Double = 1,
            style: Kind = .solid,
            dashArray: [Double]? = nil
        ) {
            self.width = width
            self.style = style
            self.dashArray = dashArray
        }
    }
}
