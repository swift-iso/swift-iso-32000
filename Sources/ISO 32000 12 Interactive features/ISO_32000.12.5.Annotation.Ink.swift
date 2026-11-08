public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation {
    public struct Ink: Sendable, Hashable {

        public var inkList: [[Double]]

        public init(inkList: [[Double]]) {
            self.inkList = inkList
        }
    }
}
