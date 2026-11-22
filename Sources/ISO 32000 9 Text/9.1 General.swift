public import Byte
import ISO_32000_Annex_D
public import ISO_32000_Shared

extension ISO.`32000` {

    public struct Text: Sendable, Equatable, Hashable {

        public var content: [Byte]

        public var state: State

        public init(_ string: String, state: State = .init()) {
            self.content = [Byte](winAnsi: string, withFallback: true)
            self.state = state
        }

        public init(bytes: [Byte], state: State = .init()) {
            self.content = bytes
            self.state = state
        }
    }
}

extension ISO.`32000`.Text {

    public var string: String? {
        String(winAnsi: content)
    }
}
