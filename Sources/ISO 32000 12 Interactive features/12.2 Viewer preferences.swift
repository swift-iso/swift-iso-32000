public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `2` {}
}

extension ISO_32000.`12`.`2` {

    public enum Boundary: String, Sendable, Hashable, Codable, CaseIterable {

        case mediaBox = "MediaBox"

        case cropBox = "CropBox"

        case bleedBox = "BleedBox"

        case trimBox = "TrimBox"

        case artBox = "ArtBox"
    }
}

extension ISO_32000.`12`.`2` {

    public struct PageRange: Sendable, Hashable, Codable {

        public var first: Int

        public var last: Int

        public init(first: Int, last: Int) {
            self.first = first
            self.last = last
        }

        public init(page: Int) {
            self.first = page
            self.last = page
        }
    }
}

extension ISO_32000.`12`.`2` {

    public struct Viewer: Sendable, Hashable, Codable {

        public var hideToolbar: Bool

        public var hideMenubar: Bool

        public var hideWindowUI: Bool

        public var fitWindow: Bool

        public var centerWindow: Bool

        public var displayDocTitle: Bool

        public var nonFullScreenPageMode: NonFullScreenPageMode

        public var direction: Direction

        public var view: View

        public var print: Print

        public var enforce: [EnforceableSetting]

        public init(
            hideToolbar: Bool = false,
            hideMenubar: Bool = false,
            hideWindowUI: Bool = false,
            fitWindow: Bool = false,
            centerWindow: Bool = false,
            displayDocTitle: Bool = false,
            nonFullScreenPageMode: NonFullScreenPageMode = .useNone,
            direction: Direction = .leftToRight,
            view: View = .init(),
            print: Print = .init(),
            enforce: [EnforceableSetting] = []
        ) {
            self.hideToolbar = hideToolbar
            self.hideMenubar = hideMenubar
            self.hideWindowUI = hideWindowUI
            self.fitWindow = fitWindow
            self.centerWindow = centerWindow
            self.displayDocTitle = displayDocTitle
            self.nonFullScreenPageMode = nonFullScreenPageMode
            self.direction = direction
            self.view = view
            self.print = print
            self.enforce = enforce
        }
    }
}

extension ISO_32000.`12`.`2`.Viewer {

    public static let `default` = Self()
}

extension ISO_32000.`12`.`2`.Viewer {

    public struct View: Sendable, Hashable, Codable {

        public var area: ISO_32000.`12`.`2`.Boundary

        public var clip: ISO_32000.`12`.`2`.Boundary

        public init(
            area: ISO_32000.`12`.`2`.Boundary = .cropBox,
            clip: ISO_32000.`12`.`2`.Boundary = .cropBox
        ) {
            self.area = area
            self.clip = clip
        }
    }
}

extension ISO_32000.`12`.`2`.Viewer {

    public struct Print: Sendable, Hashable, Codable {

        public var area: ISO_32000.`12`.`2`.Boundary

        public var clip: ISO_32000.`12`.`2`.Boundary

        public var scaling: ISO_32000.`12`.`2`.Print.Scaling

        public var duplex: ISO_32000.`12`.`2`.Print.Duplex?

        public var pickTrayByPDFSize: Bool?

        public var pageRange: [ISO_32000.`12`.`2`.PageRange]?

        public var numCopies: Int?

        public init(
            area: ISO_32000.`12`.`2`.Boundary = .cropBox,
            clip: ISO_32000.`12`.`2`.Boundary = .cropBox,
            scaling: ISO_32000.`12`.`2`.Print.Scaling = .appDefault,
            duplex: ISO_32000.`12`.`2`.Print.Duplex? = nil,
            pickTrayByPDFSize: Bool? = nil,
            pageRange: [ISO_32000.`12`.`2`.PageRange]? = nil,
            numCopies: Int? = nil
        ) {
            self.area = area
            self.clip = clip
            self.scaling = scaling
            self.duplex = duplex
            self.pickTrayByPDFSize = pickTrayByPDFSize
            self.pageRange = pageRange
            self.numCopies = numCopies
        }
    }
}

extension ISO_32000.`12`.`2` {

    public enum NonFullScreenPageMode: String, Sendable, Hashable, Codable, CaseIterable {

        case useNone = "UseNone"

        case useOutlines = "UseOutlines"

        case useThumbs = "UseThumbs"

        case useOC = "UseOC"
    }
}

extension ISO_32000.`12`.`2` {

    public enum Direction: String, Sendable, Hashable, Codable, CaseIterable {

        case leftToRight = "L2R"

        case rightToLeft = "R2L"
    }
}

extension ISO_32000.`12`.`2` {

    public enum Print {}
}

extension ISO_32000.`12`.`2`.Print {

    public enum Scaling: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "None"

        case appDefault = "AppDefault"
    }
}

extension ISO_32000.`12`.`2`.Print {

    public enum Duplex: String, Sendable, Hashable, Codable, CaseIterable {

        case simplex = "Simplex"

        case duplexFlipShortEdge = "DuplexFlipShortEdge"

        case duplexFlipLongEdge = "DuplexFlipLongEdge"
    }
}

extension ISO_32000.`12`.`2` {

    public enum EnforceableSetting: String, Sendable, Hashable, Codable, CaseIterable {

        case printScaling = "PrintScaling"
    }
}

extension ISO_32000 {

    public typealias Viewer = ISO_32000.`12`.`2`.Viewer

    public typealias NonFullScreenPageMode = ISO_32000.`12`.`2`.NonFullScreenPageMode

    public typealias Direction = ISO_32000.`12`.`2`.Direction

    public typealias Print = ISO_32000.`12`.`2`.Print
}
