import ISO_32000_12_Interactive_features
import ISO_32000_8_Graphics

extension ISO_32000 {
    public struct Resources: Sendable {

        public var fonts: [COS.Name: Font]

        public var xObjects: [COS.Name: Image]

        public init() {
            self.fonts = [:]
            self.xObjects = [:]
        }

        public init(fonts: [COS.Name: Font], xObjects: [COS.Name: Image] = [:]) {
            self.fonts = fonts
            self.xObjects = xObjects
        }
    }
}
