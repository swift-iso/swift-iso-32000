public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Stamp: Sendable, Hashable {

        public var iconName: IconName

        public var intent: Intent

        public init(
            iconName: IconName = .draft,
            intent: Intent = .stamp
        ) {
            self.iconName = iconName
            self.intent = intent
        }
    }
}
