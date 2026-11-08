public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Caret: Sendable, Hashable {

        public var rectangleDifferences: Shape.RectangleDifferences?

        public var symbol: Symbol

        public init(
            rectangleDifferences: Shape.RectangleDifferences? = nil,
            symbol: Symbol = .none
        ) {
            self.rectangleDifferences = rectangleDifferences
            self.symbol = symbol
        }
    }
}
