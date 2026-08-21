import ISO_32000_8_Graphics
import ISO_32000_9_Text

extension ISO_32000 {

    public enum Graphics {}
}

extension ISO_32000.Graphics {

    public enum State {}
}

extension ISO_32000.Graphics.State {

    public typealias DeviceIndependent = ISO_32000.`8`.`4`.Graphics.State.Device.Independent<
        ISO_32000.Text.State
    >

    public typealias DeviceDependent = ISO_32000.`8`.`4`.Graphics.State.Device.Dependent

    public typealias Stack<T: Sendable> = ISO_32000.`8`.`4`.Graphics.State.Stack<T>
}

extension ISO_32000 {

    public typealias GraphicsState = `8`.`4`.Graphics.State.Device.Independent<Text.State>
}

extension ISO_32000.GraphicsState {

    public init() {
        self.init(textState: .init())
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Stack where State == ISO_32000.GraphicsState {

    @inlinable
    public mutating func setFontSize(_ size: ISO_32000.UserSpace.Size<1>) {
        current.textState.fontSize = size
    }

    @inlinable
    public mutating func setLeading(_ leading: ISO_32000.TextSpace.Dy) {
        current.textState.leading = leading
    }

    @inlinable
    public mutating func setRise(_ rise: ISO_32000.TextSpace.Dy) {
        current.textState.rise = rise
    }

    @inlinable
    public mutating func setCharacterSpacing(_ spacing: ISO_32000.TextSpace.Dx) {
        current.textState.characterSpacing = spacing
    }

    @inlinable
    public mutating func setWordSpacing(_ spacing: ISO_32000.TextSpace.Dx) {
        current.textState.wordSpacing = spacing
    }
}
