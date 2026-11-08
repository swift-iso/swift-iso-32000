public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Link: Sendable, Hashable {

        public var target: Target

        public var highlightMode: HighlightMode

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]?

        public init(
            target: Target,
            highlightMode: HighlightMode = .invert,
            quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]? = nil
        ) {
            self.target = target
            self.highlightMode = highlightMode
            self.quadPoints = quadPoints
        }

        public init(uri: RFC_3986.URI, highlightMode: HighlightMode = .invert) {
            self.target = .uri(uri)
            self.highlightMode = highlightMode
            self.quadPoints = nil
        }

        public init(destination: ISO_32000.Destination, highlightMode: HighlightMode = .invert) {
            self.target = .destination(destination)
            self.highlightMode = highlightMode
            self.quadPoints = nil
        }
    }
}
