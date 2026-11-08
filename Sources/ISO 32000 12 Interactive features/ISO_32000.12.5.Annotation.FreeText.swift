public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct FreeText: Sendable, Hashable {

        public var defaultAppearance: String

        public var quadding: Quadding

        public var intent: Intent

        public var calloutLine: [Double]?

        public var lineEnding: ISO_32000.`12`.`5`.LineEnding

        public init(
            defaultAppearance: String,
            quadding: Quadding = .leftJustified,
            intent: Intent = .freeText,
            calloutLine: [Double]? = nil,
            lineEnding: ISO_32000.`12`.`5`.LineEnding = .none
        ) {
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
            self.intent = intent
            self.calloutLine = calloutLine
            self.lineEnding = lineEnding
        }
    }
}
