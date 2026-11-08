public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Poly: Sendable, Hashable {

        public var kind: Kind

        public var vertices: [Double]

        public var startLineEnding: ISO_32000.`12`.`5`.LineEnding?

        public var endLineEnding: ISO_32000.`12`.`5`.LineEnding?

        public var interiorColor: Color?

        public var intent: Intent?

        public init(
            kind: Kind,
            vertices: [Double],
            startLineEnding: ISO_32000.`12`.`5`.LineEnding? = nil,
            endLineEnding: ISO_32000.`12`.`5`.LineEnding? = nil,
            interiorColor: Color? = nil,
            intent: Intent? = nil
        ) {
            self.kind = kind
            self.vertices = vertices
            self.startLineEnding = startLineEnding
            self.endLineEnding = endLineEnding
            self.interiorColor = interiorColor
            self.intent = intent
        }
    }
}
