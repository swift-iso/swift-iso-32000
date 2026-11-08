public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
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
