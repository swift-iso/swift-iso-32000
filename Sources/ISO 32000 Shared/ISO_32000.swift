public import Dimension_Primitives
@_exported public import Geometry_Primitives
import Numeric_Primitives

public enum ISO_32000 {}

extension ISO_32000 {

    public typealias UserSpace = Geometry<Double, ISO_32000_Shared.UserSpace>
}

public enum UserSpace: Numeric.Quantized {}

extension UserSpace {
    public typealias Scalar = Double
    public static var quantum: Double { 0.01 }
}

extension ISO_32000.UserSpace {

    public typealias Coordinate = ISO_32000.Point<ISO_32000_Shared.UserSpace>
}

extension ISO_32000.UserSpace.Rectangle {

    public var origin: ISO_32000.UserSpace.Coordinate {
        .init(x: llx, y: lly)
    }
}
