public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Border {
    public struct Effect: Sendable, Hashable {

        public var effect: Kind

        public var intensity: Double

        public init(effect: Kind = .none, intensity: Double = 0) {
            self.effect = effect
            self.intensity = intensity
        }
    }
}
