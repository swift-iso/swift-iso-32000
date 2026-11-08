public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Outline {
    public struct ItemOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
