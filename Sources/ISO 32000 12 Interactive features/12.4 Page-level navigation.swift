public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `4` {}
}

extension ISO_32000 {
}

extension ISO_32000.PageLabel {
}

extension ISO_32000.PageLabel.Entry {
}

extension ISO_32000 {
}

extension ISO_32000.Article {
}

extension ISO_32000.Article {
}

extension ISO_32000.Article {
}

extension ISO_32000 {
}

extension ISO_32000.Transition {
}

extension ISO_32000.Transition {
}

extension ISO_32000.Transition {
}

extension ISO_32000.Transition {
}

extension ISO_32000.Transition.Direction {

    public var degrees: Int? {
        switch self {
        case .leftToRight: return 0
        case .bottomToTop: return 90
        case .rightToLeft: return 180
        case .topToBottom: return 270
        case .diagonal: return 315
        case .none: return nil
        }
    }
}

extension ISO_32000.Transition {
}

extension ISO_32000 {
}

extension ISO_32000.Navigation {
}

extension ISO_32000.`12`.`4` {

    public typealias Label = ISO_32000.PageLabel.Entry

    public typealias Thread = ISO_32000.Article.Thread

    public typealias Bead = ISO_32000.Article.Bead

    public typealias TransitionStyle = ISO_32000.Transition.Style

    public typealias TransitionEffect = ISO_32000.Transition.Effect

    public typealias NavigationNode = ISO_32000.Navigation.Node
}
