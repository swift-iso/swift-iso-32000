public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000 {
    public enum Destination: Sendable, Equatable, Hashable {

        case xyz(
            page: Int,
            left: ISO_32000.UserSpace.X?,
            top: ISO_32000.UserSpace.Y?,
            zoom: Double?
        )

        case fit(page: Int)

        case fitH(page: Int, top: ISO_32000.UserSpace.Y?)

        case fitV(page: Int, left: ISO_32000.UserSpace.X?)

        case fitR(
            page: Int,
            left: ISO_32000.UserSpace.X,
            bottom: ISO_32000.UserSpace.Y,
            right: ISO_32000.UserSpace.X,
            top: ISO_32000.UserSpace.Y
        )

        case fitB(page: Int)

        case fitBH(page: Int, top: ISO_32000.UserSpace.Y?)

        case fitBV(page: Int, left: ISO_32000.UserSpace.X?)

        case named(String)
    }
}
