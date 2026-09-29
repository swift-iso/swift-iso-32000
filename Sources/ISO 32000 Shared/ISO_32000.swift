public import Spatial
@_exported public import Geometry
import Quantizer

public enum ISO_32000 {}

extension ISO_32000 {

    public typealias UserSpace = Geometry<Double, ISO_32000_Shared.UserSpace>
}

public enum UserSpace: Quantizer::Quantized {}

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
