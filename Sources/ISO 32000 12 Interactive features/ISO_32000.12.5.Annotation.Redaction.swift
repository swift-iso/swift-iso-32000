public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Redaction: Sendable, Hashable {

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]?

        public var interiorColor: Color?

        public var overlayText: String?

        public var repeatText: Bool

        public var quadding: FreeText.Quadding

        public init(
            quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]? = nil,
            interiorColor: Color? = nil,
            overlayText: String? = nil,
            repeatText: Bool = false,
            quadding: FreeText.Quadding = .leftJustified
        ) {
            self.quadPoints = quadPoints
            self.interiorColor = interiorColor
            self.overlayText = overlayText
            self.repeatText = repeatText
            self.quadding = quadding
        }
    }
}
