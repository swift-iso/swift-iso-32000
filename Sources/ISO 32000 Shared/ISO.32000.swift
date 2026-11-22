public import Geometry
public import ISO
import Quantizer
internal import Space

extension ISO {
    public enum `32000` {}
}

extension ISO.`32000` {

    public typealias UserSpace = Geometry<Double, ISO_32000_Shared.UserSpace>
}

extension UserSpace {
    public typealias Scalar = Double
    public static var quantum: Double { 0.01 }
}

extension ISO.`32000`.UserSpace {

    public typealias Coordinate = ISO.`32000`.Point<ISO_32000_Shared.UserSpace>
}

extension ISO.`32000`.UserSpace.Rectangle {

    public var origin: ISO.`32000`.UserSpace.Coordinate {
        .init(x: llx, y: lly)
    }
}
