public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct TextMarkup: Sendable, Hashable {

        public var kind: Kind

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]

        public init(kind: Kind, quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]) {
            self.kind = kind
            self.quadPoints = quadPoints
        }
    }
}
