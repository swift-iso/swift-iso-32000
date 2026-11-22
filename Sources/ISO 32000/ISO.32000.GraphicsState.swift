import ISO_32000_8_Graphics
import ISO_32000_9_Text

extension ISO.`32000` {

    public enum Graphics {}
}

extension ISO.`32000`.Graphics {
}

extension ISO.`32000`.Graphics.State {

    public typealias DeviceIndependent = ISO.`32000`.`8`.`4`.Graphics.State.Device.Independent<
        ISO.`32000`.Text.State
    >

    public typealias DeviceDependent = ISO.`32000`.`8`.`4`.Graphics.State.Device.Dependent

    public typealias Stack<T: Sendable> = ISO.`32000`.`8`.`4`.Graphics.State.Stack<T>
}

extension ISO.`32000` {

    public typealias GraphicsState = `8`.`4`.Graphics.State.Device.Independent<Text.State>
}

extension ISO.`32000`.GraphicsState {

    public init() {
        self.init(textState: .init())
    }
}

extension ISO.`32000`.`8`.`4`.Graphics.State.Stack where State == ISO.`32000`.GraphicsState {

    @inlinable
    public mutating func setFontSize(_ size: ISO.`32000`.UserSpace.Size<1>) {
        current.textState.fontSize = size
    }

    @inlinable
    public mutating func setLeading(_ leading: ISO.`32000`.TextSpace.Dy) {
        current.textState.leading = leading
    }

    @inlinable
    public mutating func setRise(_ rise: ISO.`32000`.TextSpace.Dy) {
        current.textState.rise = rise
    }

    @inlinable
    public mutating func setCharacterSpacing(_ spacing: ISO.`32000`.TextSpace.Dx) {
        current.textState.characterSpacing = spacing
    }

    @inlinable
    public mutating func setWordSpacing(_ spacing: ISO.`32000`.TextSpace.Dx) {
        current.textState.wordSpacing = spacing
    }
}
