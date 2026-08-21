public import IEC_61966
public import ISO_32000_Shared

extension ISO_32000.`8`.`6`.Color {

    public init(_ srgb: IEC_61966.`2`.`1`.sRGB) {
        self = .rgb(r: srgb.r, g: srgb.g, b: srgb.b)
    }

    public init(
        hue: IEC_61966.`2`.`1`.Hue,
        saturation: IEC_61966.`2`.`1`.Saturation,
        lightness: IEC_61966.`2`.`1`.Lightness
    ) {
        let srgb = IEC_61966.`2`.`1`.sRGB(
            hue: hue,
            saturation: saturation,
            lightness: lightness
        )
        self.init(srgb)
    }

    public init(
        hue: IEC_61966.`2`.`1`.Hue,
        whiteness: IEC_61966.`2`.`1`.Whiteness,
        blackness: IEC_61966.`2`.`1`.Blackness
    ) {
        let srgb = IEC_61966.`2`.`1`.sRGB(
            hue: hue,
            whiteness: whiteness,
            blackness: blackness
        )
        self.init(srgb)
    }
}

extension IEC_61966.`2`.`1`.sRGB {

    public init(_ color: ISO_32000.`8`.`6`.Color) {
        switch color {
        case .gray(let g):
            self.init(gray: g)

        case .rgb(let r, let g, let b):
            self.init(r: r, g: g, b: b)

        case .cmyk(let c, let m, let y, let k):

            let r = (1 - c) * (1 - k)
            let g = (1 - m) * (1 - k)
            let b = (1 - y) * (1 - k)
            self.init(r: r, g: g, b: b)
        }
    }
}

extension ISO_32000.`8`.`6`.Color {

    public typealias sRGB = IEC_61966.`2`.`1`.sRGB

    public typealias Hue = IEC_61966.`2`.`1`.Hue

    public typealias Saturation = IEC_61966.`2`.`1`.Saturation

    public typealias Lightness = IEC_61966.`2`.`1`.Lightness

    public typealias Whiteness = IEC_61966.`2`.`1`.Whiteness

    public typealias Blackness = IEC_61966.`2`.`1`.Blackness
}
