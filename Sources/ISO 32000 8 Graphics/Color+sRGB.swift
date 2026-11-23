public import IEC_61966
public import ISO_32000_Shared

extension ISO.`32000`.`8`.`6`.Color {

    public init(_ srgb: IEC.`61966`.`2`.`1`.SRGB) {
        self = .rgb(r: srgb.r, g: srgb.g, b: srgb.b)
    }

    public init(
        hue: IEC.`61966`.`2`.`1`.Hue,
        saturation: IEC.`61966`.`2`.`1`.Saturation,
        lightness: IEC.`61966`.`2`.`1`.Lightness
    ) {
        let srgb = IEC.`61966`.`2`.`1`.SRGB(
            hue: hue,
            saturation: saturation,
            lightness: lightness
        )
        self.init(srgb)
    }

    public init(
        hue: IEC.`61966`.`2`.`1`.Hue,
        whiteness: IEC.`61966`.`2`.`1`.Whiteness,
        blackness: IEC.`61966`.`2`.`1`.Blackness
    ) {
        let srgb = IEC.`61966`.`2`.`1`.SRGB(
            hue: hue,
            whiteness: whiteness,
            blackness: blackness
        )
        self.init(srgb)
    }
}

extension IEC.`61966`.`2`.`1`.SRGB {

    public init(_ color: ISO.`32000`.`8`.`6`.Color) {
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

extension ISO.`32000`.`8`.`6`.Color {

    public typealias sRGB = IEC.`61966`.`2`.`1`.SRGB

    public typealias Hue = IEC.`61966`.`2`.`1`.Hue

    public typealias Saturation = IEC.`61966`.`2`.`1`.Saturation

    public typealias Lightness = IEC.`61966`.`2`.`1`.Lightness

    public typealias Whiteness = IEC.`61966`.`2`.`1`.Whiteness

    public typealias Blackness = IEC.`61966`.`2`.`1`.Blackness
}
