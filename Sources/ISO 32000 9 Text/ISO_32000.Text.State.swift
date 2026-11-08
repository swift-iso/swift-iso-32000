import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import Space


extension ISO_32000.Text {
    public struct State: Sendable, Equatable, Hashable {

        public var characterSpacing: ISO_32000.TextSpace.Dx

        public var wordSpacing: ISO_32000.TextSpace.Dx

        public var horizontalScaling: Scale<1, Double>

        public var leading: ISO_32000.TextSpace.Dy

        public var font: Font.Reference?

        public var fontSize: ISO_32000.UserSpace.Size<1>?

        public var renderingMode: Rendering.Mode

        public var rise: ISO_32000.TextSpace.Dy

        public var knockout: Bool

        public init(
            characterSpacing: ISO_32000.TextSpace.Dx = .init(0),
            wordSpacing: ISO_32000.TextSpace.Dx = .init(0),
            horizontalScaling: Scale<1, Double> = 100,
            leading: ISO_32000.TextSpace.Dy = .init(0),
            font: Font.Reference? = nil,
            fontSize: ISO_32000.UserSpace.Size<1>? = nil,
            renderingMode: Rendering.Mode = .fill,
            rise: ISO_32000.TextSpace.Dy = .init(0),
            knockout: Bool = true
        ) {
            self.characterSpacing = characterSpacing
            self.wordSpacing = wordSpacing
            self.horizontalScaling = horizontalScaling
            self.leading = leading
            self.font = font
            self.fontSize = fontSize
            self.renderingMode = renderingMode
            self.rise = rise
            self.knockout = knockout
        }
    }
}
