public import ISO_32000_Shared


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
