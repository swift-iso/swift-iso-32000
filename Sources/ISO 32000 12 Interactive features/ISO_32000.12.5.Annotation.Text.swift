public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Text: Sendable, Hashable {

        public var isOpen: Bool

        public var iconName: IconName

        public var state: State?

        public init(
            isOpen: Bool = false,
            iconName: IconName = .note,
            state: State? = nil
        ) {
            self.isOpen = isOpen
            self.iconName = iconName
            self.state = state
        }
    }
}
