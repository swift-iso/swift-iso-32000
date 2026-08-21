import Dimension_Primitives
public import Geometry_Primitives
public import ISO_32000_Shared

@_spi(Internal) import struct Dimension_Primitives.Tagged

extension ISO_32000.`8` {

    public enum `3` {}
}

extension ISO_32000.`8`.`3` {

    public enum `2` {}
}

extension ISO_32000.`8`.`3`.`2` {

    public enum `3` {}
}

extension ISO_32000.`8`.`3`.`2`.`3` {

    public typealias UserSpace = ISO_32000.UserSpace
}

extension ISO_32000.UserSpace.Length {

    public static let inch: Self = .init(72)

    @inlinable
    public static func inches(_ value: Double) -> Self { Self(value * 72) }

    @inlinable
    public static func millimeters(_ value: Double) -> Self { Self(value * 2.83465) }

    @inlinable
    public static func centimeters(_ value: Double) -> Self { Self(value * 28.3465) }

    @inlinable
    public static func pixels(_ value: Double, dpi: Double = 96) -> Self { Self(value * 72 / dpi) }

    @inlinable
    public var inches: Self { Self(underlying / 72) }

    @inlinable
    public var millimeters: Self { Self(underlying / 2.83465) }

    @inlinable
    public var centimeters: Self { Self(underlying / 28.3465) }
}

extension ISO_32000.UserSpace.Width {

    public static let inch: Self = .init(72)

    @inlinable
    public static func inches(_ value: Double) -> Self { Self(value * 72) }

    @inlinable
    public static func millimeters(_ value: Double) -> Self { Self(value * 2.83465) }

    @inlinable
    public static func centimeters(_ value: Double) -> Self { Self(value * 28.3465) }

    @inlinable
    public static func pixels(_ value: Double, dpi: Double = 96) -> Self { Self(value * 72 / dpi) }
}

extension ISO_32000.UserSpace.Height {

    public static let inch: Self = .init(72)

    @inlinable
    public static func inches(_ value: Double) -> Self { Self(value * 72) }

    @inlinable
    public static func millimeters(_ value: Double) -> Self { Self(value * 2.83465) }

    @inlinable
    public static func centimeters(_ value: Double) -> Self { Self(value * 28.3465) }

    @inlinable
    public static func pixels(_ value: Double, dpi: Double = 96) -> Self { Self(value * 72 / dpi) }
}

extension ISO_32000.`8`.`3`.`2`.`3`.UserSpace.Rectangle {

    public static let a4 = Self(
        x: .init(0),
        y: .init(0),
        width: .init(595.276),
        height: .init(841.890)
    )

    public static let a3 = Self(
        x: .init(0),
        y: .init(0),
        width: .init(841.890),
        height: .init(1190.551)
    )

    public static let a5 = Self(
        x: .init(0),
        y: .init(0),
        width: .init(419.528),
        height: .init(595.276)
    )

    public static let letter = Self(x: .init(0), y: .init(0), width: .init(612), height: .init(792))

    public static let legal = Self(x: .init(0), y: .init(0), width: .init(612), height: .init(1008))

    public static let tabloid = Self(
        x: .init(0),
        y: .init(0),
        width: .init(792),
        height: .init(1224)
    )
}

extension ISO_32000.`8`.`3`.`2`.`3`.UserSpace.Rectangle {

    public var landscape: Self {

        if width >= height { return self }
        var result = self

        result.halfExtents = Geometry.Size(
            width: halfExtents.height.retag(Extent.X<UserSpace>.self),
            height: halfExtents.width.retag(Extent.Y<UserSpace>.self)
        )
        return result
    }

    public var portrait: Self {
        if height >= width { return self }
        var result = self
        result.halfExtents = Geometry.Size(
            width: halfExtents.height.retag(Extent.X<UserSpace>.self),
            height: halfExtents.width.retag(Extent.Y<UserSpace>.self)
        )
        return result
    }
}

extension ISO_32000.`8`.`3`.`2`.`3`.UserSpace.Coordinate {

    public static func fromTopLeft(
        x: ISO_32000.UserSpace.X,
        topY: ISO_32000.UserSpace.Dy,
        pageTop: ISO_32000.UserSpace.Y
    ) -> Self {
        Self(x: x, y: pageTop - topY)
    }

    public func topLeftY(
        pageTop: ISO_32000.UserSpace.Y
    ) -> ISO_32000.UserSpace.Dy {
        pageTop - y
    }
}

extension ISO_32000.`8`.`3`.`2`.`3`.UserSpace.Rectangle {

    public static func fromTopLeft(
        x: ISO_32000.UserSpace.X,
        topY: ISO_32000.UserSpace.Dy,
        width: ISO_32000.UserSpace.Width,
        height: ISO_32000.UserSpace.Height,
        pageTop: ISO_32000.UserSpace.Y
    ) -> Self {

        let topLeftY: ISO_32000.UserSpace.Y = pageTop - topY
        let bottomLeftY: ISO_32000.UserSpace.Y =
            topLeftY - height.retag(Displacement.Y<UserSpace>.self)
        return Self(
            x: x,
            y: bottomLeftY,
            width: width,
            height: height
        )
    }

    public func topY(
        pageTop: ISO_32000.UserSpace.Y
    ) -> ISO_32000.UserSpace.Dy {
        pageTop - ury
    }

    public func topLeftOrigin(
        pageTop: ISO_32000.UserSpace.Y
    ) -> (x: ISO_32000.UserSpace.X, topY: ISO_32000.UserSpace.Dy) {
        (x: llx, topY: pageTop - ury)
    }
}
