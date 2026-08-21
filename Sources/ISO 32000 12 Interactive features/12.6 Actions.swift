public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `6` {}
}

extension ISO_32000 {

    public enum Action {}
}

extension ISO_32000.Action {

    public enum Kind: String, Sendable, Codable, CaseIterable {

        case goTo = "GoTo"

        case goToR = "GoToR"

        case goToE = "GoToE"

        case goToDp = "GoToDp"

        case launch = "Launch"

        case thread = "Thread"

        case uri = "URI"

        case sound = "Sound"

        case movie = "Movie"

        case hide = "Hide"

        case named = "Named"

        case submitForm = "SubmitForm"

        case resetForm = "ResetForm"

        case importData = "ImportData"

        case setOCGState = "SetOCGState"

        case rendition = "Rendition"

        case trans = "Trans"

        case goTo3DView = "GoTo3DView"

        case javaScript = "JavaScript"

        case richMediaExecute = "RichMediaExecute"
    }
}

extension ISO_32000.Action {

    public struct GoTo: Sendable {

        public var destination: ISO_32000.Destination

        public var structureDestination: [String]?

        public init(destination: ISO_32000.Destination) {
            self.destination = destination
            self.structureDestination = nil
        }
    }
}

extension ISO_32000.Action {

    public struct GoToR: Sendable {

        public var file: String

        public var destination: ISO_32000.Destination

        public var newWindow: Bool?

        public init(file: String, destination: ISO_32000.Destination, newWindow: Bool? = nil) {
            self.file = file
            self.destination = destination
            self.newWindow = newWindow
        }
    }
}

extension ISO_32000.Action {

    public struct URI: Sendable, Equatable, Hashable, Codable {

        public var uri: String

        public var isMap: Bool

        public init(uri: String, isMap: Bool = false) {
            self.uri = uri
            self.isMap = isMap
        }
    }
}

extension ISO_32000.Action {

    public struct Hide: Sendable, Equatable, Hashable, Codable {

        public var target: Target

        public var hide: Bool

        public init(target: Target, hide: Bool = true) {
            self.target = target
            self.hide = hide
        }
    }
}

extension ISO_32000.Action.Hide {

    public enum Target: Sendable, Equatable, Hashable, Codable {

        case annotation(Int)

        case field(String)

        case multiple([Target])
    }
}

extension ISO_32000.Action {

    public struct Named: Sendable, Equatable, Hashable, Codable {

        public var name: Name

        public init(name: Name) {
            self.name = name
        }
    }
}

extension ISO_32000.Action.Named {

    public enum Name: String, Sendable, Codable, CaseIterable {

        case nextPage = "NextPage"

        case prevPage = "PrevPage"

        case firstPage = "FirstPage"

        case lastPage = "LastPage"
    }
}

extension ISO_32000.Action {

    public struct JavaScript: Sendable, Equatable, Hashable, Codable {

        public var script: String

        public init(script: String) {
            self.script = script
        }
    }
}

extension ISO_32000.Action {

    public struct GoToE: Sendable, Hashable {

        public var file: String?

        public var destination: ISO_32000.Destination

        public var target: Target?

        public var newWindow: Bool?

        public init(
            destination: ISO_32000.Destination,
            file: String? = nil,
            target: Target? = nil,
            newWindow: Bool? = nil
        ) {
            self.destination = destination
            self.file = file
            self.target = target
            self.newWindow = newWindow
        }
    }

    public final class Box<T: Sendable & Hashable>: @unchecked Sendable, Hashable {
        public let value: T

        public init(_ value: T) {
            self.value = value
        }

        public static func == (lhs: Box<T>, rhs: Box<T>) -> Bool {
            lhs.value == rhs.value
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
}

extension ISO_32000.Action.GoToE {

    public struct Target: Sendable, Hashable {

        public var relation: Relation

        public var name: String?

        public var pageNumber: Int?

        public var annotationIndex: Int?

        public var next: ISO_32000.Action.Box<Target>?

        public init(
            relation: Relation,
            name: String? = nil,
            pageNumber: Int? = nil,
            annotationIndex: Int? = nil,
            next: Target? = nil
        ) {
            self.relation = relation
            self.name = name
            self.pageNumber = pageNumber
            self.annotationIndex = annotationIndex
            self.next = next.map { ISO_32000.Action.Box($0) }
        }
    }
}

extension ISO_32000.Action.GoToE.Target {

    public enum Relation: String, Sendable, Hashable, Codable, CaseIterable {

        case parent = "P"

        case child = "C"
    }
}

extension ISO_32000.Action {

    public struct GoToDp: Sendable, Hashable {

        public var dpart: Int

        public init(dpart: Int) {
            self.dpart = dpart
        }
    }
}

extension ISO_32000.Action {

    public struct Launch: Sendable, Hashable {

        public var file: String?

        public var win: WindowsLaunch?

        public var newWindow: Bool?

        public init(
            file: String? = nil,
            win: WindowsLaunch? = nil,
            newWindow: Bool? = nil
        ) {
            self.file = file
            self.win = win
            self.newWindow = newWindow
        }
    }
}

extension ISO_32000.Action.Launch {

    public struct WindowsLaunch: Sendable, Hashable {

        public var file: String

        public var directory: String?

        public var operation: Operation?

        public var parameters: String?

        public init(
            file: String,
            directory: String? = nil,
            operation: Operation? = nil,
            parameters: String? = nil
        ) {
            self.file = file
            self.directory = directory
            self.operation = operation
            self.parameters = parameters
        }
    }
}

extension ISO_32000.Action.Launch.WindowsLaunch {

    public enum Operation: String, Sendable, Hashable, Codable, CaseIterable {

        case open

        case print
    }
}

extension ISO_32000.Action {

    public struct Thread: Sendable, Hashable {

        public var file: String?

        public var thread: ThreadSpec

        public var bead: BeadSpec?

        public init(
            thread: ThreadSpec,
            file: String? = nil,
            bead: BeadSpec? = nil
        ) {
            self.thread = thread
            self.file = file
            self.bead = bead
        }
    }
}

extension ISO_32000.Action.Thread {

    public enum ThreadSpec: Sendable, Hashable {

        case index(Int)

        case title(String)

        case reference(Int)
    }

    public enum BeadSpec: Sendable, Hashable {

        case index(Int)

        case reference(Int)
    }
}

extension ISO_32000.Action {

    public struct SetOCGState: Sendable, Hashable {

        public var state: [StateChange]

        public var preserveRB: Bool

        public init(state: [StateChange], preserveRB: Bool = true) {
            self.state = state
            self.preserveRB = preserveRB
        }
    }
}

extension ISO_32000.Action.SetOCGState {

    public enum Command: String, Sendable, Hashable, Codable, CaseIterable {

        case on = "ON"

        case off = "OFF"

        case toggle = "Toggle"
    }

    public struct StateChange: Sendable, Hashable {

        public var command: Command

        public var ocgs: [Int]

        public init(command: Command, ocgs: [Int]) {
            self.command = command
            self.ocgs = ocgs
        }
    }
}

extension ISO_32000.Action {

    public struct Rendition: Sendable, Hashable {

        public var operation: Operation?

        public var annotation: Int?

        public var rendition: Int?

        public var javaScript: String?

        public init(
            operation: Operation? = nil,
            annotation: Int? = nil,
            rendition: Int? = nil,
            javaScript: String? = nil
        ) {
            self.operation = operation
            self.annotation = annotation
            self.rendition = rendition
            self.javaScript = javaScript
        }
    }
}

extension ISO_32000.Action.Rendition {

    public enum Operation: Int, Sendable, Hashable, Codable, CaseIterable {

        case play = 0

        case stop = 1

        case pause = 2

        case resume = 3

        case playFromAnnotation = 4
    }
}

extension ISO_32000.Action {

    public struct Transition: Sendable, Hashable {

        public var trans: TransitionDict

        public init(trans: TransitionDict) {
            self.trans = trans
        }
    }
}

extension ISO_32000.Action.Transition {

    public struct TransitionDict: Sendable, Hashable {

        public var style: Style

        public var duration: Double

        public init(style: Style = .replace, duration: Double = 1) {
            self.style = style
            self.duration = duration
        }
    }
}

extension ISO_32000.Action.Transition.TransitionDict {

    public enum Style: String, Sendable, Hashable, Codable, CaseIterable {

        case split = "Split"

        case blinds = "Blinds"

        case box = "Box"

        case wipe = "Wipe"

        case dissolve = "Dissolve"

        case glitter = "Glitter"

        case replace = "R"

        case fly = "Fly"

        case push = "Push"

        case cover = "Cover"

        case uncover = "Uncover"

        case fade = "Fade"
    }
}

extension ISO_32000.Action {

    public struct RichMediaExecute: Sendable, Hashable {

        public var annotation: Int

        public var command: Command

        public init(annotation: Int, command: Command) {
            self.annotation = annotation
            self.command = command
        }
    }
}

extension ISO_32000.Action.RichMediaExecute {

    public struct Command: Sendable, Hashable {

        public var type: CommandType

        public var name: String?

        public var argument: String?

        public init(type: CommandType, name: String? = nil, argument: String? = nil) {
            self.type = type
            self.name = name
            self.argument = argument
        }
    }
}

extension ISO_32000.Action.RichMediaExecute.Command {

    public enum CommandType: String, Sendable, Hashable, Codable, CaseIterable {

        case javaScript = "cycscript"
    }
}

extension ISO_32000.Action {

    public struct FormFieldTriggers: Sendable, Hashable {

        public var keystroke: JavaScript?

        public var format: JavaScript?

        public var validate: JavaScript?

        public var calculate: JavaScript?

        public init(
            keystroke: JavaScript? = nil,
            format: JavaScript? = nil,
            validate: JavaScript? = nil,
            calculate: JavaScript? = nil
        ) {
            self.keystroke = keystroke
            self.format = format
            self.validate = validate
            self.calculate = calculate
        }
    }

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

extension ISO_32000.`12`.`6` {

    public typealias Kind = ISO_32000.Action.Kind

    public typealias GoTo = ISO_32000.Action.GoTo

    public typealias GoToR = ISO_32000.Action.GoToR

    public typealias GoToE = ISO_32000.Action.GoToE

    public typealias GoToDp = ISO_32000.Action.GoToDp

    public typealias Launch = ISO_32000.Action.Launch

    public typealias Thread = ISO_32000.Action.Thread

    public typealias URI = ISO_32000.Action.URI

    public typealias Hide = ISO_32000.Action.Hide

    public typealias Named = ISO_32000.Action.Named

    public typealias SetOCGState = ISO_32000.Action.SetOCGState

    public typealias Rendition = ISO_32000.Action.Rendition

    public typealias Transition = ISO_32000.Action.Transition

    public typealias JavaScript = ISO_32000.Action.JavaScript

    public typealias RichMediaExecute = ISO_32000.Action.RichMediaExecute

    public typealias FormFieldTriggers = ISO_32000.Action.FormFieldTriggers

    public typealias AnnotationTriggers = ISO_32000.Action.AnnotationTriggers
}
