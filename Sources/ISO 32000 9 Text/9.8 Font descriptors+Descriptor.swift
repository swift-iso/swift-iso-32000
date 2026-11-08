public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared

extension ISO_32000.`9`.`8` {

    public struct Descriptor: Sendable, Equatable {

        public let fontName: ISO_32000.`7`.`3`.COS.Name

        public let flags: Flags

        public let fontBBox: BoundingBox

        public let italicAngle: Double

        public let ascent: ISO_32000.FontDesign.Height

        public let descent: ISO_32000.FontDesign.Height

        public let leading: ISO_32000.FontDesign.Height

        public let capHeight: ISO_32000.FontDesign.Height

        public let xHeight: ISO_32000.FontDesign.Height

        public let stemV: ISO_32000.FontDesign.Width

        public let stemH: ISO_32000.FontDesign.Width?

        public let missingWidth: ISO_32000.FontDesign.Width

        public init(
            fontName: ISO_32000.`7`.`3`.COS.Name,
            flags: Flags,
            fontBBox: BoundingBox,
            italicAngle: Double,
            ascent: ISO_32000.FontDesign.Height,
            descent: ISO_32000.FontDesign.Height,
            leading: ISO_32000.FontDesign.Height = .init(0),
            capHeight: ISO_32000.FontDesign.Height,
            xHeight: ISO_32000.FontDesign.Height,
            stemV: ISO_32000.FontDesign.Width,
            stemH: ISO_32000.FontDesign.Width? = nil,
            missingWidth: ISO_32000.FontDesign.Width = .init(0)
        ) {
            self.fontName = fontName
            self.flags = flags
            self.fontBBox = fontBBox
            self.italicAngle = italicAngle
            self.ascent = ascent
            self.descent = descent
            self.leading = leading
            self.capHeight = capHeight
            self.xHeight = xHeight
            self.stemV = stemV
            self.stemH = stemH
            self.missingWidth = missingWidth
        }
    }
}

extension ISO_32000.`9`.`8`.Descriptor {

    public struct BoundingBox: Sendable, Equatable {

        public let llx: Int

        public let lly: Int

        public let urx: Int

        public let ury: Int

        public init(llx: Int, lly: Int, urx: Int, ury: Int) {
            self.llx = llx
            self.lly = lly
            self.urx = urx
            self.ury = ury
        }
    }
}

extension ISO_32000.`9`.`8`.Descriptor {

    public struct Flags: OptionSet, Sendable, Equatable {
        public let rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.`9`.`8`.Descriptor.Flags {

    public static let fixedPitch = Self(rawValue: 1 << 0)

    public static let serif = Self(rawValue: 1 << 1)

    public static let symbolic = Self(rawValue: 1 << 2)

    public static let script = Self(rawValue: 1 << 3)

    public static let nonsymbolic = Self(rawValue: 1 << 5)

    public static let italic = Self(rawValue: 1 << 6)

    public static let allCap = Self(rawValue: 1 << 16)

    public static let smallCap = Self(rawValue: 1 << 17)

    public static let forceBold = Self(rawValue: 1 << 18)
}

extension ISO_32000.`9`.`8`.Descriptor {

    public init(
        fontFile: ISO_14496_22.FontFile,
        fontName: ISO_32000.`7`.`3`.COS.Name
    ) {

        var flags: Flags = []

        if fontFile.post.isFixedPitch {
            flags.insert(.fixedPitch)
        }

        flags.insert(.nonsymbolic)

        if fontFile.post.italicAngle != 0 {
            flags.insert(.italic)
        }

        let unitsPerEm = Int(fontFile.head.unitsPerEm)
        func scale(_ value: Int) -> Int {
            (value * 1000) / unitsPerEm
        }

        let fontBBox = BoundingBox(
            llx: scale(Int(fontFile.head.xMin)),
            lly: scale(Int(fontFile.head.yMin)),
            urx: scale(Int(fontFile.head.xMax)),
            ury: scale(Int(fontFile.head.yMax))
        )

        let ascent = ISO_32000.FontDesign.Height(scale(Int(fontFile.hhea.ascender)))
        let descent = ISO_32000.FontDesign.Height(scale(Int(fontFile.hhea.descender)))
        let leading = ISO_32000.FontDesign.Height(scale(Int(fontFile.hhea.lineGap)))

        let capHeight = ascent
        let xHeight = ISO_32000.FontDesign.Height(ascent.underlying * 2 / 3)

        let stemV = ISO_32000.FontDesign.Width(80)

        let missingWidth = ISO_32000.FontDesign.Width(
            scale(Int(fontFile.hmtx.advanceWidth(for: 0)))
        )

        self.init(
            fontName: fontName,
            flags: flags,
            fontBBox: fontBBox,
            italicAngle: fontFile.post.italicAngle,
            ascent: ascent,
            descent: descent,
            leading: leading,
            capHeight: capHeight,
            xHeight: xHeight,
            stemV: stemV,
            missingWidth: missingWidth
        )
    }
}
