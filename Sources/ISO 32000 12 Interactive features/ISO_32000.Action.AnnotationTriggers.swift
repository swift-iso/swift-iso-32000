public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct AnnotationTriggers: Sendable, Hashable {

        public var cursorEnter: JavaScript?

        public var cursorExit: JavaScript?

        public var mouseDown: JavaScript?

        public var mouseUp: JavaScript?

        public var focus: JavaScript?

        public var blur: JavaScript?

        public var pageOpen: JavaScript?

        public var pageClose: JavaScript?

        public var pageVisible: JavaScript?

        public var pageInvisible: JavaScript?

        public init(
            cursorEnter: JavaScript? = nil,
            cursorExit: JavaScript? = nil,
            mouseDown: JavaScript? = nil,
            mouseUp: JavaScript? = nil,
            focus: JavaScript? = nil,
            blur: JavaScript? = nil,
            pageOpen: JavaScript? = nil,
            pageClose: JavaScript? = nil,
            pageVisible: JavaScript? = nil,
            pageInvisible: JavaScript? = nil
        ) {
            self.cursorEnter = cursorEnter
            self.cursorExit = cursorExit
            self.mouseDown = mouseDown
            self.mouseUp = mouseUp
            self.focus = focus
            self.blur = blur
            self.pageOpen = pageOpen
            self.pageClose = pageClose
            self.pageVisible = pageVisible
            self.pageInvisible = pageInvisible
        }
    }
}
