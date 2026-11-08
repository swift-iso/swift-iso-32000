public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Outline {
    public struct Item: Sendable {

        public var title: String

        public var target: Target?

        public var children: [Item]

        public var isOpen: Bool

        public var color: ISO_32000.DeviceRGB?

        public var flags: ItemOptions

        public init(
            title: String,
            target: Target? = nil,
            children: [Item] = [],
            isOpen: Bool = true,
            color: ISO_32000.DeviceRGB? = nil,
            flags: ItemOptions = []
        ) {
            self.title = title
            self.target = target
            self.children = children
            self.isOpen = isOpen
            self.color = color
            self.flags = flags
        }

        public init(
            title: String,
            destination: ISO_32000.Destination,
            children: [Item] = [],
            isOpen: Bool = true,
            color: ISO_32000.DeviceRGB? = nil,
            flags: ItemOptions = []
        ) {
            self.init(
                title: title,
                target: .destination(destination),
                children: children,
                isOpen: isOpen,
                color: color,
                flags: flags
            )
        }

        public init(
            title: String,
            action: ISO_32000.Action.Kind,
            children: [Item] = [],
            isOpen: Bool = true,
            color: ISO_32000.DeviceRGB? = nil,
            flags: ItemOptions = []
        ) {
            self.init(
                title: title,
                target: .action(action),
                children: children,
                isOpen: isOpen,
                color: color,
                flags: flags
            )
        }
    }
}
