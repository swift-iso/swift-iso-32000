public import Byte
public import ISO_32000_Shared


extension ISO_32000.`9`.`4` {
    public struct Matrix: Sendable, Hashable {

        public var a: Double

        public var b: Double

        public var c: Double

        public var d: Double

        public var e: Double

        public var f: Double

        public init(
            a: Double = 1,
            b: Double = 0,
            c: Double = 0,
            d: Double = 1,
            e: Double = 0,
            f: Double = 0
        ) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
        }
    }
}
