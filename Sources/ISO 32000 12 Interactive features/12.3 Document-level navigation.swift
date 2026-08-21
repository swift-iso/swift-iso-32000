public import Geometry_Primitives
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `3` {}
}

extension ISO_32000 {

    public enum Destination: Sendable, Equatable, Hashable {

        case xyz(
            page: Int,
            left: ISO_32000.UserSpace.X?,
            top: ISO_32000.UserSpace.Y?,
            zoom: Double?
        )

        case fit(page: Int)

        case fitH(page: Int, top: ISO_32000.UserSpace.Y?)

        case fitV(page: Int, left: ISO_32000.UserSpace.X?)

        case fitR(
            page: Int,
            left: ISO_32000.UserSpace.X,
            bottom: ISO_32000.UserSpace.Y,
            right: ISO_32000.UserSpace.X,
            top: ISO_32000.UserSpace.Y
        )

        case fitB(page: Int)

        case fitBH(page: Int, top: ISO_32000.UserSpace.Y?)

        case fitBV(page: Int, left: ISO_32000.UserSpace.X?)

        case named(String)
    }
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

    public enum Outline {}
}

extension ISO_32000.Outline {

    public struct Root: Sendable {

        public var items: [Item]

        public init(items: [Item] = []) {
            self.items = items
        }
    }
}

extension ISO_32000.Outline.Root {

    public var count: Int {
        items.reduce(0) { $0 + $1.visibleDescendantCount }
    }

    public var isEmpty: Bool { items.isEmpty }
}

extension ISO_32000.Outline {

    public enum Target: Sendable {

        case destination(ISO_32000.Destination)

        case action(ISO_32000.Action.Kind)
    }
}

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

extension ISO_32000.Outline.Item {

    public var visibleDescendantCount: Int {
        guard !children.isEmpty else { return 1 }
        if isOpen {
            return 1 + children.reduce(0) { $0 + $1.visibleDescendantCount }
        } else {
            return 1
        }
    }
}

extension ISO_32000.Outline {

    public struct ItemOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Outline.ItemOptions {

    public static let italic = ISO_32000.Outline.ItemOptions(rawValue: 1 << 0)

    public static let bold = ISO_32000.Outline.ItemOptions(rawValue: 1 << 1)
}

extension ISO_32000.`12`.`3` {

    public struct Collection: Sendable {

        public var view: CollectionView

        public var initialDocument: String?

        public var sort: CollectionSort?

        public init(
            view: CollectionView = .details,
            initialDocument: String? = nil,
            sort: CollectionSort? = nil
        ) {
            self.view = view
            self.initialDocument = initialDocument
            self.sort = sort
        }
    }

    public enum CollectionView: String, Sendable, Hashable, Codable, CaseIterable {

        case details = "D"

        case tile = "T"

        case hidden = "H"

        case custom = "C"
    }

    public struct CollectionSort: Sendable {

        public var fields: [String]

        public var ascending: [Bool]

        public init(fields: [String], ascending: [Bool] = [true]) {
            self.fields = fields
            self.ascending = ascending
        }
    }

    public enum CollectionFieldSubtype: String, Sendable, Hashable, Codable, CaseIterable {

        case text = "S"

        case date = "D"

        case number = "N"

        case fileName = "F"

        case description = "Desc"

        case modificationDate = "ModDate"

        case creationDate = "CreationDate"

        case size = "Size"

        case compressedSize = "CompressedSize"
    }
}

extension ISO_32000.`12`.`3` {

    public enum NavigatorLayout: String, Sendable, Hashable, Codable, CaseIterable {

        case details = "D"

        case tile = "T"

        case hidden = "H"

        case filmStrip = "FilmStrip"

        case freeForm = "FreeForm"

        case linear = "Linear"

        case tree = "Tree"
    }
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

    public typealias DeviceRGB = IEC_61966.sRGB

    public typealias OutlineRoot = Outline.Root

    public typealias OutlineItem = Outline.Item

    public typealias OutlineItemTarget = Outline.Target

    public typealias OutlineItemFlags = Outline.ItemOptions
}
