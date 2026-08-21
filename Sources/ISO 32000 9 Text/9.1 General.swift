public import Byte_Primitives
import ISO_32000_Annex_D
public import ISO_32000_Shared

extension ISO_32000 {

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

extension ISO_32000.Text {

    public var string: String? {
        String(winAnsi: content)
    }
}
