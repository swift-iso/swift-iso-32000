public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `3` {}
}

extension ISO_32000 {
}

extension ISO_32000.Destination {

    public var pageIndex: Int? {
        switch self {
        case .xyz(let page, _, _, _): return page
        case .fit(let page): return page
        case .fitH(let page, _): return page
        case .fitV(let page, _): return page
        case .fitR(let page, _, _, _, _): return page
        case .fitB(let page): return page
        case .fitBH(let page, _): return page
        case .fitBV(let page, _): return page
        case .named: return nil
        }
    }
}

extension ISO_32000 {
}

extension ISO_32000.Outline {
}

extension ISO_32000.Outline.Root {

    public var count: Int {
        items.reduce(0) { $0 + $1.visibleDescendantCount }
    }

    public var isEmpty: Bool { items.isEmpty }
}

extension ISO_32000.Outline {
}

extension ISO_32000.Outline {
}

extension ISO_32000.Outline.Item {

    public var visibleDescendantCount: Int {
        guard !children.isEmpty else { return 1 }
        guard isOpen else {
            return 1
        }
        return 1 + children.reduce(0) { $0 + $1.visibleDescendantCount }
    }
}

extension ISO_32000.Outline {
}

extension ISO_32000.Outline.ItemOptions {

    public static let italic = ISO_32000.Outline.ItemOptions(rawValue: 1 << 0)

    public static let bold = ISO_32000.Outline.ItemOptions(rawValue: 1 << 1)
}

extension ISO_32000.`12`.`3` {
}

extension ISO_32000.`12`.`3` {
}

extension ISO_32000.Outline {

    public static func build(
        from headings: [(
            level: Int,
            title: String,
            pageIndex: Int,
            yPosition: ISO_32000.UserSpace.Y
        )],
        openToLevel: Int = 1,
        color: ISO_32000.DeviceRGB? = nil,
        flags: ItemOptions = []
    ) -> Root {
        guard !headings.isEmpty else { return Root() }

        var rootItems: [Item] = []
        var stack: [(level: Int, item: Item)] = []

        for heading in headings {
            let destination = ISO_32000.Destination.xyz(
                page: heading.pageIndex,
                left: nil,
                top: heading.yPosition,
                zoom: nil
            )

            let item = Item(
                title: heading.title,
                target: .destination(destination),
                children: [],
                isOpen: heading.level <= openToLevel,
                color: color,
                flags: flags
            )

            while let last = stack.last, last.level >= heading.level {
                let (_, child) = stack.removeLast()
                if stack.isEmpty {
                    rootItems.append(child)
                } else {
                    var (parentLevel, parentItem) = stack.removeLast()
                    parentItem = Item(
                        title: parentItem.title,
                        target: parentItem.target,
                        children: parentItem.children + [child],
                        isOpen: parentItem.isOpen,
                        color: parentItem.color,
                        flags: parentItem.flags
                    )
                    stack.append((parentLevel, parentItem))
                }
            }

            stack.append((heading.level, item))
        }

        while let (_, child) = stack.popLast() {
            if stack.isEmpty {
                rootItems.append(child)
            } else {
                var (parentLevel, parentItem) = stack.removeLast()
                parentItem = Item(
                    title: parentItem.title,
                    target: parentItem.target,
                    children: parentItem.children + [child],
                    isOpen: parentItem.isOpen,
                    color: parentItem.color,
                    flags: parentItem.flags
                )
                stack.append((parentLevel, parentItem))
            }
        }

        return Root(items: rootItems)
    }
}

extension ISO_32000.`12`.`3` {

    public typealias OutlineRoot = ISO_32000.Outline.Root

    public typealias OutlineItem = ISO_32000.Outline.Item

    public typealias OutlineItemTarget = ISO_32000.Outline.Target

    public typealias OutlineItemFlags = ISO_32000.Outline.ItemOptions

    public typealias Destination = ISO_32000.Destination
}

extension ISO_32000 {

    public typealias DeviceRGB = IEC_61966.SRGB

    public typealias OutlineRoot = Outline.Root

    public typealias OutlineItem = Outline.Item

    public typealias OutlineItemTarget = Outline.Target

    public typealias OutlineItemFlags = Outline.ItemOptions
}
