public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Line: Sendable, Hashable {

        public var startX: Double

        public var startY: Double

        public var endX: Double

        public var endY: Double

        public var startLineEnding: ISO_32000.`12`.`5`.LineEnding

        public var endLineEnding: ISO_32000.`12`.`5`.LineEnding

        public var interiorColor: Color?

        public var leaderLineLength: Double

        public var leaderLineExtension: Double

        public var leaderLineOffset: Double

        public var hasCaption: Bool

        public var captionPosition: CaptionPosition

        public var captionOffsetX: Double

        public var captionOffsetY: Double

        public var intent: Intent?

        public init(
            startX: Double,
            startY: Double,
            endX: Double,
            endY: Double,
            startLineEnding: ISO_32000.`12`.`5`.LineEnding = .none,
            endLineEnding: ISO_32000.`12`.`5`.LineEnding = .none,
            interiorColor: Color? = nil,
            leaderLineLength: Double = 0,
            leaderLineExtension: Double = 0,
            leaderLineOffset: Double = 0,
            hasCaption: Bool = false,
            captionPosition: CaptionPosition = .inline,
            captionOffsetX: Double = 0,
            captionOffsetY: Double = 0,
            intent: Intent? = nil
        ) {
            self.startX = startX
            self.startY = startY
            self.endX = endX
            self.endY = endY
            self.startLineEnding = startLineEnding
            self.endLineEnding = endLineEnding
            self.interiorColor = interiorColor
            self.leaderLineLength = leaderLineLength
            self.leaderLineExtension = leaderLineExtension
            self.leaderLineOffset = leaderLineOffset
            self.hasCaption = hasCaption
            self.captionPosition = captionPosition
            self.captionOffsetX = captionOffsetX
            self.captionOffsetY = captionOffsetY
            self.intent = intent
        }
    }
}
