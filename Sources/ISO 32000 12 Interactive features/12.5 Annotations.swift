public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646

extension ISO_32000.`12` {

    public enum `5` {}
}

extension ISO_32000.`12`.`5` {
}

extension ISO_32000.`12`.`5`.Annotation {

    public var subtype: Subtype { content.subtype }
}

extension ISO_32000.`12`.`5`.Annotation {
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

        do {
            return try ISO_32000.`7`.`3`.COS.Name(rawValue)
        } catch {
            preconditionFailure("An annotation subtype raw value is a valid PDF name: \(error)")
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation {
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
}

extension ISO_32000.`12`.`5`.Border {

    public static let `default` = ISO_32000.`12`.`5`.Border()

    public static let none = ISO_32000.`12`.`5`.Border(width: 0)
}

extension ISO_32000.`12`.`5`.Border {
}

extension ISO_32000.`12`.`5`.Border.Style {


    public static let `default` = ISO_32000.`12`.`5`.Border.Style()
}

extension ISO_32000.`12`.`5`.Border {
}

extension ISO_32000.`12`.`5`.Border.Effect {
}

extension ISO_32000.`12`.`5` {
}

extension ISO_32000.`12`.`5`.Appearance {
}

extension ISO_32000.`12`.`5` {
}

extension ISO_32000.`12`.`5` {
}

extension ISO_32000.`12`.`5`.Markup {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Link {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.TextMarkup {
}

extension ISO_32000.`12`.`5`.Annotation {
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
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Text {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.FreeText {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Line {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Shape {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Poly {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Caret {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.Stamp {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000.`12`.`5`.Annotation.FileAttachment {
}

extension ISO_32000.`12`.`5`.Annotation {
}

extension ISO_32000 {

    public typealias Annotation = ISO_32000.`12`.`5`.Annotation

    public typealias Border = ISO_32000.`12`.`5`.Border

    public typealias Appearance = ISO_32000.`12`.`5`.Appearance

    public typealias Markup = ISO_32000.`12`.`5`.Markup

    public typealias LineEnding = ISO_32000.`12`.`5`.LineEnding
}
