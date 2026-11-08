public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Shape: Sendable, Hashable {

        public var kind: Kind

        public var interiorColor: Color?

        public var rectangleDifferences: RectangleDifferences?

        public init(
            kind: Kind,
            interiorColor: Color? = nil,
            rectangleDifferences: RectangleDifferences? = nil
        ) {
            self.kind = kind
            self.interiorColor = interiorColor
            self.rectangleDifferences = rectangleDifferences
        }
    }
}
