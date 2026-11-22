import ISO_32000_8_Graphics

@_spi(Internal) public import struct Geometry.Tagged

extension ISO.`32000`.COS.Object {

    public init(_ rect: ISO.`32000`.UserSpace.Rectangle) {
        self = .array([
            .real(rect.llx.underlying),
            .real(rect.lly.underlying),
            .real(rect.urx.underlying),
            .real(rect.ury.underlying),
        ])
    }
}
