public import Geometry_Primitives
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `5` {}
}

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

        public var language: String?

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
            language: String? = nil,
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

extension ISO_32000.`12`.`5`.Annotation {

    public var subtype: Subtype { content.subtype }
}

extension ISO_32000.`12`.`5`.Annotation {

    public enum Content: Sendable, Hashable {

        case link(Link)

        case text(Text)

        case freeText(FreeText)

        case line(Line)

        case shape(Shape)

        case poly(Poly)

        case textMarkup(TextMarkup)

        case caret(Caret)

        case stamp(Stamp)

        case ink(Ink)

        case popup(Popup)

        case fileAttachment(FileAttachment)

        case redaction(Redaction)

        case widget(Widget)
    }
}

extension ISO_32000.`12`.`5`.Annotation.Content {

    public var subtype: ISO_32000.`12`.`5`.Annotation.Subtype {
        switch self {
        case .link: return .link
        case .text: return .text
        case .freeText: return .freeText
        case .line: return .line
        case .shape(let s): return s.kind == .square ? .square : .circle
        case .poly(let p): return p.kind == .polygon ? .polygon : .polyLine

        case .textMarkup(let tm):
            switch tm.kind {
            case .highlight: return .highlight
            case .underline: return .underline
            case .strikeOut: return .strikeOut
            case .squiggly: return .squiggly
            }

        case .caret: return .caret
        case .stamp: return .stamp
        case .ink: return .ink
        case .popup: return .popup
        case .fileAttachment: return .fileAttachment
        case .redaction: return .redact
        case .widget: return .widget
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public enum Subtype: String, Sendable, Hashable, Codable, CaseIterable {

        case text = "Text"

        case link = "Link"

        case freeText = "FreeText"

        case line = "Line"

        case square = "Square"

        case circle = "Circle"

        case polygon = "Polygon"

        case polyLine = "PolyLine"

        case highlight = "Highlight"

        case underline = "Underline"

        case squiggly = "Squiggly"

        case strikeOut = "StrikeOut"

        case caret = "Caret"

        case stamp = "Stamp"

        case ink = "Ink"

        case popup = "Popup"

        case fileAttachment = "FileAttachment"

        case sound = "Sound"

        case movie = "Movie"

        case screen = "Screen"

        case widget = "Widget"

        case printerMark = "PrinterMark"

        case trapNet = "TrapNet"

        case watermark = "Watermark"

        case threeD = "3D"

        case redact = "Redact"

        case projection = "Projection"

        case richMedia = "RichMedia"
    }
}

extension ISO_32000.`12`.`5`.Annotation.Subtype {

    public var isMarkup: Bool {
        switch self {
        case .text, .freeText, .line, .square, .circle,
            .polygon, .polyLine, .highlight, .underline,
            .squiggly, .strikeOut, .caret, .stamp, .ink,
            .fileAttachment, .sound, .redact, .projection:
            return true

        case .link, .popup, .movie, .screen, .widget,
            .printerMark, .trapNet, .watermark, .threeD, .richMedia:
            return false
        }
    }

    public var isTextMarkup: Bool {
        switch self {
        case .highlight, .underline, .squiggly, .strikeOut:
            return true

        default:
            return false
        }
    }

    public var name: ISO_32000.`7`.`3`.COS.Name {

        try! ISO_32000.`7`.`3`.COS.Name(rawValue)
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Flags: OptionSet, Sendable, Hashable, Codable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Flags {

    public static let invisible = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 0)

    public static let hidden = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 1)

    public static let print = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 2)

    public static let noZoom = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 3)

    public static let noRotate = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 4)

    public static let noView = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 5)

    public static let readOnly = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 6)

    public static let locked = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 7)

    public static let toggleNoView = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 8)

    public static let lockedContents = ISO_32000.`12`.`5`.Annotation.Flags(rawValue: 1 << 9)
}

extension ISO_32000.`12`.`5`.Annotation {

    public enum Color: Sendable, Hashable {

        case transparent

        case gray(Double)

        case rgb(red: Double, green: Double, blue: Double)

        case cmyk(cyan: Double, magenta: Double, yellow: Double, black: Double)
    }
}

extension ISO_32000.`12`.`5`.Annotation.Color {

    public static func rgb(
        _ red: Double,
        _ green: Double,
        _ blue: Double
    ) -> ISO_32000.`12`.`5`.Annotation.Color {
        .rgb(red: red, green: green, blue: blue)
    }
}

extension ISO_32000.`12`.`5` {

    public struct Border: Sendable, Hashable {

        public var horizontalRadius: Double

        public var verticalRadius: Double

        public var width: Double

        public var dashArray: [Double]?

        public init(
            horizontalRadius: Double = 0,
            verticalRadius: Double = 0,
            width: Double = 1,
            dashArray: [Double]? = nil
        ) {
            self.horizontalRadius = horizontalRadius
            self.verticalRadius = verticalRadius
            self.width = width
            self.dashArray = dashArray
        }
    }
}

extension ISO_32000.`12`.`5`.Border {

    public static let `default` = ISO_32000.`12`.`5`.Border()

    public static let none = ISO_32000.`12`.`5`.Border(width: 0)
}

extension ISO_32000.`12`.`5`.Border {

    public struct Style: Sendable, Hashable {

        public var width: Double

        public var style: Kind

        public var dashArray: [Double]?

        public init(
            width: Double = 1,
            style: Kind = .solid,
            dashArray: [Double]? = nil
        ) {
            self.width = width
            self.style = style
            self.dashArray = dashArray
        }
    }
}

extension ISO_32000.`12`.`5`.Border.Style {

    public enum Kind: String, Sendable, Hashable, Codable, CaseIterable {

        case solid = "S"

        case dashed = "D"

        case beveled = "B"

        case inset = "I"

        case underline = "U"
    }

    public static let `default` = ISO_32000.`12`.`5`.Border.Style()
}

extension ISO_32000.`12`.`5`.Border {

    public struct Effect: Sendable, Hashable {

        public var effect: Kind

        public var intensity: Double

        public init(effect: Kind = .none, intensity: Double = 0) {
            self.effect = effect
            self.intensity = intensity
        }
    }
}

extension ISO_32000.`12`.`5`.Border.Effect {

    public enum Kind: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "S"

        case cloudy = "C"
    }
}

extension ISO_32000.`12`.`5` {

    public struct Appearance: Sendable, Hashable {

        public var normal: Entry

        public var rollover: Entry?

        public var down: Entry?

        public init(
            normal: Entry,
            rollover: Entry? = nil,
            down: Entry? = nil
        ) {
            self.normal = normal
            self.rollover = rollover
            self.down = down
        }
    }
}

extension ISO_32000.`12`.`5`.Appearance {

    public enum Entry: Sendable, Hashable {

        case stream(String)

        case subdictionary([String: String])
    }
}

extension ISO_32000.`12`.`5` {

    public enum TabOrder: String, Sendable, Hashable, Codable, CaseIterable {

        case row = "R"

        case column = "C"

        case structure = "S"

        case annotationArray = "A"

        case widgets = "W"
    }
}

extension ISO_32000.`12`.`5` {

    public struct Markup: Sendable, Hashable {

        public var title: String?

        public var richContents: String?

        public var creationDate: String?

        public var inReplyTo: String?

        public var subject: String?

        public var replyType: ReplyType?

        public var intent: String?

        public init(
            title: String? = nil,
            richContents: String? = nil,
            creationDate: String? = nil,
            inReplyTo: String? = nil,
            subject: String? = nil,
            replyType: ReplyType? = nil,
            intent: String? = nil
        ) {
            self.title = title
            self.richContents = richContents
            self.creationDate = creationDate
            self.inReplyTo = inReplyTo
            self.subject = subject
            self.replyType = replyType
            self.intent = intent
        }
    }
}

extension ISO_32000.`12`.`5`.Markup {

    public enum ReplyType: String, Sendable, Hashable, Codable, CaseIterable {

        case reply = "R"

        case group = "Group"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Link: Sendable, Hashable {

        public var target: Target

        public var highlightMode: HighlightMode

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]?

        public init(
            target: Target,
            highlightMode: HighlightMode = .invert,
            quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]? = nil
        ) {
            self.target = target
            self.highlightMode = highlightMode
            self.quadPoints = quadPoints
        }

        public init(uri: String, highlightMode: HighlightMode = .invert) {
            self.target = .uri(uri)
            self.highlightMode = highlightMode
            self.quadPoints = nil
        }

        public init(destination: ISO_32000.Destination, highlightMode: HighlightMode = .invert) {
            self.target = .destination(destination)
            self.highlightMode = highlightMode
            self.quadPoints = nil
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Link {

    public enum Target: Sendable, Hashable {

        case uri(String)

        case destination(ISO_32000.Destination)
    }

    public enum HighlightMode: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "N"

        case invert = "I"

        case outline = "O"

        case push = "P"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct TextMarkup: Sendable, Hashable {

        public var kind: Kind

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]

        public init(kind: Kind, quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]) {
            self.kind = kind
            self.quadPoints = quadPoints
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.TextMarkup {

    public enum Kind: Sendable, Hashable {

        case highlight(ISO_32000.`12`.`5`.Annotation.Color)

        case underline

        case strikeOut

        case squiggly
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public enum StateModel: String, Sendable, Hashable, Codable, CaseIterable {

        case marked = "Marked"

        case review = "Review"
    }

    public enum State: Sendable, Hashable {

        case marked

        case unmarked

        case accepted

        case rejected

        case cancelled

        case completed

        case none
    }
}

extension ISO_32000.`12`.`5`.Annotation.State {

    public var stateModel: ISO_32000.`12`.`5`.Annotation.StateModel {
        switch self {
        case .marked, .unmarked:
            return .marked

        case .accepted, .rejected, .cancelled, .completed, .none:
            return .review
        }
    }

    public var rawValue: String {
        switch self {
        case .marked: return "Marked"
        case .unmarked: return "Unmarked"
        case .accepted: return "Accepted"
        case .rejected: return "Rejected"
        case .cancelled: return "Cancelled"
        case .completed: return "Completed"
        case .none: return "None"
        }
    }
}

extension ISO_32000.`12`.`5` {

    public enum LineEnding: String, Sendable, Hashable, Codable, CaseIterable {

        case square = "Square"

        case circle = "Circle"

        case diamond = "Diamond"

        case openArrow = "OpenArrow"

        case closedArrow = "ClosedArrow"

        case none = "None"

        case butt = "Butt"

        case rOpenArrow = "ROpenArrow"

        case rClosedArrow = "RClosedArrow"

        case slash = "Slash"
    }
}

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

extension ISO_32000.`12`.`5`.Annotation.Text {

    public enum IconName: String, Sendable, Hashable, Codable, CaseIterable {
        case comment = "Comment"
        case key = "Key"
        case note = "Note"
        case help = "Help"
        case newParagraph = "NewParagraph"
        case paragraph = "Paragraph"
        case insert = "Insert"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct FreeText: Sendable, Hashable {

        public var defaultAppearance: String

        public var quadding: Quadding

        public var intent: Intent

        public var calloutLine: [Double]?

        public var lineEnding: ISO_32000.`12`.`5`.LineEnding

        public init(
            defaultAppearance: String,
            quadding: Quadding = .leftJustified,
            intent: Intent = .freeText,
            calloutLine: [Double]? = nil,
            lineEnding: ISO_32000.`12`.`5`.LineEnding = .none
        ) {
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
            self.intent = intent
            self.calloutLine = calloutLine
            self.lineEnding = lineEnding
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.FreeText {

    public enum Quadding: Int, Sendable, Hashable, Codable, CaseIterable {

        case leftJustified = 0

        case centered = 1

        case rightJustified = 2
    }

    public enum Intent: String, Sendable, Hashable, Codable, CaseIterable {

        case freeText = "FreeText"

        case freeTextCallout = "FreeTextCallout"

        case freeTextTypeWriter = "FreeTextTypeWriter"
    }
}

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

extension ISO_32000.`12`.`5`.Annotation.Line {

    public enum CaptionPosition: String, Sendable, Hashable, Codable, CaseIterable {

        case inline = "Inline"

        case top = "Top"
    }

    public enum Intent: String, Sendable, Hashable, Codable, CaseIterable {

        case lineArrow = "LineArrow"

        case lineDimension = "LineDimension"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Shape: Sendable, Hashable {

        public var kind: Kind

        public var interiorColor: Color?

        public var rectangleDifferences: RectangleDifferences?

        public init(
            kind: Kind,
            interiorColor: Color? = nil,
            rectangleDifferences: RectangleDifferences? = nil
        ) {
            self.kind = kind
            self.interiorColor = interiorColor
            self.rectangleDifferences = rectangleDifferences
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Shape {

    public enum Kind: String, Sendable, Hashable, Codable, CaseIterable {
        case square = "Square"
        case circle = "Circle"
    }

    public struct RectangleDifferences: Sendable, Hashable {
        public var left: Double
        public var top: Double
        public var right: Double
        public var bottom: Double

        public init(left: Double, top: Double, right: Double, bottom: Double) {
            self.left = left
            self.top = top
            self.right = right
            self.bottom = bottom
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Poly: Sendable, Hashable {

        public var kind: Kind

        public var vertices: [Double]

        public var startLineEnding: ISO_32000.`12`.`5`.LineEnding?

        public var endLineEnding: ISO_32000.`12`.`5`.LineEnding?

        public var interiorColor: Color?

        public var intent: Intent?

        public init(
            kind: Kind,
            vertices: [Double],
            startLineEnding: ISO_32000.`12`.`5`.LineEnding? = nil,
            endLineEnding: ISO_32000.`12`.`5`.LineEnding? = nil,
            interiorColor: Color? = nil,
            intent: Intent? = nil
        ) {
            self.kind = kind
            self.vertices = vertices
            self.startLineEnding = startLineEnding
            self.endLineEnding = endLineEnding
            self.interiorColor = interiorColor
            self.intent = intent
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Poly {

    public enum Kind: String, Sendable, Hashable, Codable, CaseIterable {
        case polygon = "Polygon"
        case polyLine = "PolyLine"
    }

    public enum Intent: String, Sendable, Hashable, Codable, CaseIterable {

        case polygonCloud = "PolygonCloud"

        case polyLineDimension = "PolyLineDimension"

        case polygonDimension = "PolygonDimension"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Caret: Sendable, Hashable {

        public var rectangleDifferences: Shape.RectangleDifferences?

        public var symbol: Symbol

        public init(
            rectangleDifferences: Shape.RectangleDifferences? = nil,
            symbol: Symbol = .none
        ) {
            self.rectangleDifferences = rectangleDifferences
            self.symbol = symbol
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Caret {

    public enum Symbol: String, Sendable, Hashable, Codable, CaseIterable {

        case paragraph = "P"

        case none = "None"
    }
}

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

extension ISO_32000.`12`.`5`.Annotation.Stamp {

    public enum IconName: String, Sendable, Hashable, Codable, CaseIterable {
        case approved = "Approved"
        case experimental = "Experimental"
        case notApproved = "NotApproved"
        case asIs = "AsIs"
        case expired = "Expired"
        case notForPublicRelease = "NotForPublicRelease"
        case confidential = "Confidential"
        case final = "Final"
        case sold = "Sold"
        case departmental = "Departmental"
        case forComment = "ForComment"
        case topSecret = "TopSecret"
        case draft = "Draft"
        case forPublicRelease = "ForPublicRelease"
    }

    public enum Intent: String, Sendable, Hashable, Codable, CaseIterable {

        case stampSnapshot = "StampSnapshot"

        case stampImage = "StampImage"

        case stamp = "Stamp"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Ink: Sendable, Hashable {

        public var inkList: [[Double]]

        public init(inkList: [[Double]]) {
            self.inkList = inkList
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Popup: Sendable, Hashable {

        public var isOpen: Bool

        public init(isOpen: Bool = false) {
            self.isOpen = isOpen
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct FileAttachment: Sendable, Hashable {

        public var iconName: IconName

        public init(iconName: IconName = .pushPin) {
            self.iconName = iconName
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.FileAttachment {

    public enum IconName: String, Sendable, Hashable, Codable, CaseIterable {
        case graph = "Graph"
        case pushPin = "PushPin"
        case paperclip = "Paperclip"
        case tag = "Tag"
    }
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Redaction: Sendable, Hashable {

        public var quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]?

        public var interiorColor: Color?

        public var overlayText: String?

        public var repeatText: Bool

        public var quadding: FreeText.Quadding

        public init(
            quadPoints: [Geometry<Double, ISO_32000.UserSpace>.Quadrilateral]? = nil,
            interiorColor: Color? = nil,
            overlayText: String? = nil,
            repeatText: Bool = false,
            quadding: FreeText.Quadding = .leftJustified
        ) {
            self.quadPoints = quadPoints
            self.interiorColor = interiorColor
            self.overlayText = overlayText
            self.repeatText = repeatText
            self.quadding = quadding
        }
    }
}

extension ISO_32000 {

    public typealias Annotation = ISO_32000.`12`.`5`.Annotation

    public typealias Border = ISO_32000.`12`.`5`.Border

    public typealias Appearance = ISO_32000.`12`.`5`.Appearance

    public typealias Markup = ISO_32000.`12`.`5`.Markup

    public typealias LineEnding = ISO_32000.`12`.`5`.LineEnding
}
