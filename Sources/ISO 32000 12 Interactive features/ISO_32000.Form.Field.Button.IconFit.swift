public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Button {
    public struct IconFit: Sendable, Hashable {

        public var scaleMode: ScaleMode

        public var proportional: Bool

        public var horizontalAlignment: Double

        public var verticalAlignment: Double

        public var fitToBounds: Bool

        public init(
            scaleMode: ScaleMode = .always,
            proportional: Bool = true,
            horizontalAlignment: Double = 0.5,
            verticalAlignment: Double = 0.5,
            fitToBounds: Bool = false
        ) {
            self.scaleMode = scaleMode
            self.proportional = proportional
            self.horizontalAlignment = horizontalAlignment
            self.verticalAlignment = verticalAlignment
            self.fitToBounds = fitToBounds
        }
    }
}
