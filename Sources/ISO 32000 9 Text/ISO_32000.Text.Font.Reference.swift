import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import Space


extension ISO_32000.Text.Font {
    public struct Reference: Sendable, Equatable, Hashable {

        public var name: String

        public init(name: String) {
            self.name = name
        }
    }
}
