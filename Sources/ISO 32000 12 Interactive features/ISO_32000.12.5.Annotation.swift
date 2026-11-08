public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5` {
    public struct Annotation: Sendable, Hashable {

        public var rect: ISO_32000.UserSpace.Rectangle

        public var contents: String?

        public var name: String?

        public var modificationDate: String?

        public var flags: Flags

        public var border: Border?

        public var color: Color?

        public var structParent: Int?

        public var fillOpacity: Double?

        public var strokeOpacity: Double?

        public var blendMode: ISO_32000.`8`.`4`.Graphics.State.Blend.Mode?

        public var language: RFC_5646.LanguageTag?

        public var appearance: ISO_32000.`12`.`5`.Appearance?

        public var appearanceState: String?

        public var content: Content

        public init(
            rect: ISO_32000.UserSpace.Rectangle,
            content: Content,
            contents: String? = nil,
            name: String? = nil,
            modificationDate: String? = nil,
            flags: Flags = [],
            border: Border? = nil,
            color: Color? = nil,
            structParent: Int? = nil,
            fillOpacity: Double? = nil,
            strokeOpacity: Double? = nil,
            blendMode: ISO_32000.`8`.`4`.Graphics.State.Blend.Mode? = nil,
            language: RFC_5646.LanguageTag? = nil,
            appearance: ISO_32000.`12`.`5`.Appearance? = nil,
            appearanceState: String? = nil
        ) {
            self.rect = rect
            self.content = content
            self.contents = contents
            self.name = name
            self.modificationDate = modificationDate
            self.flags = flags
            self.border = border
            self.color = color
            self.structParent = structParent
            self.fillOpacity = fillOpacity
            self.strokeOpacity = strokeOpacity
            self.blendMode = blendMode
            self.language = language
            self.appearance = appearance
            self.appearanceState = appearanceState
        }
    }
}
