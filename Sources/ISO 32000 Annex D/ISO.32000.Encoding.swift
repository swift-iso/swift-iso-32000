public import Byte
public import ISO_32000_Shared

extension ISO.`32000` {

    public protocol Encoding: Sendable {

        static var name: String { get }

        static func encode(_ scalar: Unicode.Scalar) -> Byte?

        static func decode(_ byte: Byte) -> Unicode.Scalar?

        static func canEncode(_ scalar: Unicode.Scalar) -> Bool

        static var decodeTable: [Unicode.Scalar?] { get }
    }
}

extension ISO.`32000`.Encoding {

    @inlinable
    public static func canEncode(_ scalar: Unicode.Scalar) -> Bool {
        encode(scalar) != nil
    }
}

extension ISO.`32000`.Encoding {

    @inlinable
    public static func encode<Scalars: Swift.Sequence>(
        _ scalars: Scalars
    ) -> [Byte]? where Scalars.Element == Unicode.Scalar {
        var result: [Byte] = []
        for scalar in scalars {
            guard let byte = encode(scalar) else { return nil }
            result.append(byte)
        }
        return result
    }

    @inlinable
    public static func encodeWithFallback<Scalars: Swift.Sequence>(
        _ scalars: Scalars
    ) -> [Byte] where Scalars.Element == Unicode.Scalar {
        var result: [Byte] = []
        for scalar in scalars {
            if let byte = encode(scalar) {
                result.append(byte)
            } else if let fallback = ISO.`32000`.unicodeFallbackMap[scalar.value] {
                result.append(contentsOf: fallback)
            } else {
                result.append(Byte(bitPattern: 0x3F))
            }
        }
        return result
    }
}

extension ISO.`32000` {

    public static let unicodeFallbackMap: [UInt32: [Byte]] =
        ([

            0x2713: [0x2A],
            0x2714: [0x2A],
            0x2715: [0x78],
            0x2716: [0x78],
            0x2717: [0x78],
            0x2718: [0x58],
            0x2610: [0x5B, 0x20, 0x5D],
            0x2611: [0x5B, 0x2A, 0x5D],
            0x2612: [0x5B, 0x78, 0x5D],

            0x2190: [0x3C, 0x2D],
            0x2191: [0x5E],
            0x2192: [0x2D, 0x3E],
            0x2193: [0x76],
            0x2194: [0x3C, 0x2D, 0x3E],
            0x21D0: [0x3C, 0x3D],
            0x21D2: [0x3D, 0x3E],
            0x21D4: [0x3C, 0x3D, 0x3E],
            0x27A1: [0x2D, 0x3E],

            0x2260: [0x21, 0x3D],
            0x2264: [0x3C, 0x3D],
            0x2265: [0x3E, 0x3D],
            0x2248: [0x7E, 0x3D],
            0x221E: [0x69, 0x6E, 0x66],
            0x2212: [0x2D],

            0x2010: [0x2D],
            0x2011: [0x2D],
            0x2012: [0x2D],
            0x2015: [0x2D, 0x2D],

            0x2018: [0x27],
            0x2019: [0x27],
            0x201A: [0x2C],
            0x201C: [0x22],
            0x201D: [0x22],
            0x201E: [0x2C, 0x2C],
            0x2039: [0x3C],
            0x203A: [0x3E],

            0x2022: [0x2A],
            0x25CF: [0x2A],
            0x25CB: [0x6F],
            0x25A0: [0x23],
            0x25A1: [0x5B, 0x5D],
            0x25AA: [0x2A],
            0x25AB: [0x2D],
            0x25B6: [0x3E],
            0x25C0: [0x3C],
            0x25B2: [0x5E],
            0x25BC: [0x76],

            0x2605: [0x2A],
            0x2606: [0x2A],

            0x00A0: [0x20],
            0x200B: [],
            0x200C: [],
            0x200D: [],
            0xFEFF: [],
        ] as [UInt32: [UInt8]]).mapValues { $0.map(Byte.init(bitPattern:)) }
}

extension Array where Element == Byte {

    @inlinable
    public init?<E: ISO.`32000`.Encoding>(
        _ string: some StringProtocol,
        encoding: E.Type
    ) {
        var result: [Byte] = []
        for scalar in string.unicodeScalars {
            guard let byte = E.encode(scalar) else { return nil }
            result.append(byte)
        }
        self = result
    }

    @inlinable
    public init<E: ISO.`32000`.Encoding>(
        _ string: some StringProtocol,
        encoding: E.Type,
        withFallback: Bool,
        preservingControlChars: Bool = false
    ) {
        var result: [Byte] = []
        for scalar in string.unicodeScalars {
            let value = scalar.value

            if preservingControlChars && value < 0x20 {
                result.append(Byte(UInt8(value)))
            } else if let byte = E.encode(scalar) {
                result.append(byte)
            } else if withFallback, let fallback = ISO.`32000`.unicodeFallbackMap[value] {
                result.append(contentsOf: fallback)
            } else {

                result.append(Byte(bitPattern: 0x3F))
            }
        }
        self = result
    }
}

extension String {

    @inlinable
    public init?<E: ISO.`32000`.Encoding, Bytes: Swift::Collection>(
        _ bytes: Bytes,
        encoding: E.Type
    ) where Bytes.Element == Byte {
        var scalars = String.UnicodeScalarView()
        scalars.reserveCapacity(bytes.count)
        for byte in bytes {
            guard let scalar = E.decode(byte) else { return nil }
            scalars.append(scalar)
        }
        self.init(scalars)
    }

    @inlinable
    public init<E: ISO.`32000`.Encoding, Bytes: Swift::Collection>(
        _ bytes: Bytes,
        encoding: E.Type,
        withReplacement: Bool
    ) where Bytes.Element == Byte {
        var scalars = String.UnicodeScalarView()
        scalars.reserveCapacity(bytes.count)
        for byte in bytes {
            if let scalar = E.decode(byte) {
                scalars.append(scalar)
            } else if withReplacement {
                scalars.append("\u{FFFD}")
            }
        }
        self.init(scalars)
    }
}

extension ISO.`32000` {

    @frozen
    public struct GlyphName: Hashable, Sendable {

        public let bytes: [Byte]

        @inlinable
        public init(bytes: [Byte]) {
            self.bytes = bytes
        }

        @inlinable
        public init(_ name: StaticString) {
            self.bytes = name.withUTF8Buffer { unsafe $0.map(Byte.init(bitPattern:)) }
        }
    }
}

extension String {

    @inlinable
    public init(_ glyphName: ISO.`32000`.GlyphName) {
        self.init(decoding: glyphName.bytes, as: UTF8.self)
    }
}

extension ISO.`32000`.GlyphName: CustomStringConvertible {
    @inlinable
    public var description: String {
        String(self)
    }
}

extension ISO.`32000`.GlyphName {

    public static let A = ISO.`32000`.GlyphName("A")
    public static let B = ISO.`32000`.GlyphName("B")
    public static let C = ISO.`32000`.GlyphName("C")
    public static let D = ISO.`32000`.GlyphName("D")
    public static let E = ISO.`32000`.GlyphName("E")
    public static let F = ISO.`32000`.GlyphName("F")
    public static let G = ISO.`32000`.GlyphName("G")
    public static let H = ISO.`32000`.GlyphName("H")
    public static let I = ISO.`32000`.GlyphName("I")
    public static let J = ISO.`32000`.GlyphName("J")
    public static let K = ISO.`32000`.GlyphName("K")
    public static let L = ISO.`32000`.GlyphName("L")
    public static let M = ISO.`32000`.GlyphName("M")
    public static let N = ISO.`32000`.GlyphName("N")
    public static let O = ISO.`32000`.GlyphName("O")
    public static let P = ISO.`32000`.GlyphName("P")
    public static let Q = ISO.`32000`.GlyphName("Q")
    public static let R = ISO.`32000`.GlyphName("R")
    public static let S = ISO.`32000`.GlyphName("S")
    public static let T = ISO.`32000`.GlyphName("T")
    public static let U = ISO.`32000`.GlyphName("U")
    public static let V = ISO.`32000`.GlyphName("V")
    public static let W = ISO.`32000`.GlyphName("W")
    public static let X = ISO.`32000`.GlyphName("X")
    public static let Y = ISO.`32000`.GlyphName("Y")
    public static let Z = ISO.`32000`.GlyphName("Z")

    public static let a = ISO.`32000`.GlyphName("a")
    public static let b = ISO.`32000`.GlyphName("b")
    public static let c = ISO.`32000`.GlyphName("c")
    public static let d = ISO.`32000`.GlyphName("d")
    public static let e = ISO.`32000`.GlyphName("e")
    public static let f = ISO.`32000`.GlyphName("f")
    public static let g = ISO.`32000`.GlyphName("g")
    public static let h = ISO.`32000`.GlyphName("h")
    public static let i = ISO.`32000`.GlyphName("i")
    public static let j = ISO.`32000`.GlyphName("j")
    public static let k = ISO.`32000`.GlyphName("k")
    public static let l = ISO.`32000`.GlyphName("l")
    public static let m = ISO.`32000`.GlyphName("m")
    public static let n = ISO.`32000`.GlyphName("n")
    public static let o = ISO.`32000`.GlyphName("o")
    public static let p = ISO.`32000`.GlyphName("p")
    public static let q = ISO.`32000`.GlyphName("q")
    public static let r = ISO.`32000`.GlyphName("r")
    public static let s = ISO.`32000`.GlyphName("s")
    public static let t = ISO.`32000`.GlyphName("t")
    public static let u = ISO.`32000`.GlyphName("u")
    public static let v = ISO.`32000`.GlyphName("v")
    public static let w = ISO.`32000`.GlyphName("w")
    public static let x = ISO.`32000`.GlyphName("x")
    public static let y = ISO.`32000`.GlyphName("y")
    public static let z = ISO.`32000`.GlyphName("z")

    public static let zero = ISO.`32000`.GlyphName("zero")
    public static let one = ISO.`32000`.GlyphName("one")
    public static let two = ISO.`32000`.GlyphName("two")
    public static let three = ISO.`32000`.GlyphName("three")
    public static let four = ISO.`32000`.GlyphName("four")
    public static let five = ISO.`32000`.GlyphName("five")
    public static let six = ISO.`32000`.GlyphName("six")
    public static let seven = ISO.`32000`.GlyphName("seven")
    public static let eight = ISO.`32000`.GlyphName("eight")
    public static let nine = ISO.`32000`.GlyphName("nine")

    public static let space = ISO.`32000`.GlyphName("space")
    public static let exclam = ISO.`32000`.GlyphName("exclam")
    public static let quotedbl = ISO.`32000`.GlyphName("quotedbl")
    public static let numbersign = ISO.`32000`.GlyphName("numbersign")
    public static let dollar = ISO.`32000`.GlyphName("dollar")
    public static let percent = ISO.`32000`.GlyphName("percent")
    public static let ampersand = ISO.`32000`.GlyphName("ampersand")
    public static let quotesingle = ISO.`32000`.GlyphName("quotesingle")
    public static let parenleft = ISO.`32000`.GlyphName("parenleft")
    public static let parenright = ISO.`32000`.GlyphName("parenright")
    public static let asterisk = ISO.`32000`.GlyphName("asterisk")
    public static let plus = ISO.`32000`.GlyphName("plus")
    public static let comma = ISO.`32000`.GlyphName("comma")
    public static let hyphen = ISO.`32000`.GlyphName("hyphen")
    public static let period = ISO.`32000`.GlyphName("period")
    public static let slash = ISO.`32000`.GlyphName("slash")
    public static let colon = ISO.`32000`.GlyphName("colon")
    public static let semicolon = ISO.`32000`.GlyphName("semicolon")
    public static let less = ISO.`32000`.GlyphName("less")
    public static let equal = ISO.`32000`.GlyphName("equal")
    public static let greater = ISO.`32000`.GlyphName("greater")
    public static let question = ISO.`32000`.GlyphName("question")
    public static let at = ISO.`32000`.GlyphName("at")
    public static let bracketleft = ISO.`32000`.GlyphName("bracketleft")
    public static let backslash = ISO.`32000`.GlyphName("backslash")
    public static let bracketright = ISO.`32000`.GlyphName("bracketright")
    public static let asciicircum = ISO.`32000`.GlyphName("asciicircum")
    public static let underscore = ISO.`32000`.GlyphName("underscore")
    public static let grave = ISO.`32000`.GlyphName("grave")
    public static let braceleft = ISO.`32000`.GlyphName("braceleft")
    public static let bar = ISO.`32000`.GlyphName("bar")
    public static let braceright = ISO.`32000`.GlyphName("braceright")
    public static let asciitilde = ISO.`32000`.GlyphName("asciitilde")

    public static let Euro = ISO.`32000`.GlyphName("Euro")
    public static let cent = ISO.`32000`.GlyphName("cent")
    public static let sterling = ISO.`32000`.GlyphName("sterling")
    public static let currency = ISO.`32000`.GlyphName("currency")
    public static let yen = ISO.`32000`.GlyphName("yen")
    public static let florin = ISO.`32000`.GlyphName("florin")

    public static let bullet = ISO.`32000`.GlyphName("bullet")
    public static let ellipsis = ISO.`32000`.GlyphName("ellipsis")
    public static let emdash = ISO.`32000`.GlyphName("emdash")
    public static let endash = ISO.`32000`.GlyphName("endash")
    public static let quoteleft = ISO.`32000`.GlyphName("quoteleft")
    public static let quoteright = ISO.`32000`.GlyphName("quoteright")
    public static let quotedblleft = ISO.`32000`.GlyphName("quotedblleft")
    public static let quotedblright = ISO.`32000`.GlyphName("quotedblright")
    public static let quotesinglbase = ISO.`32000`.GlyphName("quotesinglbase")
    public static let quotedblbase = ISO.`32000`.GlyphName("quotedblbase")
    public static let dagger = ISO.`32000`.GlyphName("dagger")
    public static let daggerdbl = ISO.`32000`.GlyphName("daggerdbl")
    public static let perthousand = ISO.`32000`.GlyphName("perthousand")
    public static let guilsinglleft = ISO.`32000`.GlyphName("guilsinglleft")
    public static let guilsinglright = ISO.`32000`.GlyphName("guilsinglright")
    public static let guillemotleft = ISO.`32000`.GlyphName("guillemotleft")
    public static let guillemotright = ISO.`32000`.GlyphName("guillemotright")

    public static let fi = ISO.`32000`.GlyphName("fi")
    public static let fl = ISO.`32000`.GlyphName("fl")
    public static let ff = ISO.`32000`.GlyphName("ff")
    public static let ffi = ISO.`32000`.GlyphName("ffi")
    public static let ffl = ISO.`32000`.GlyphName("ffl")

    public static let Aacute = ISO.`32000`.GlyphName("Aacute")
    public static let Acircumflex = ISO.`32000`.GlyphName("Acircumflex")
    public static let Adieresis = ISO.`32000`.GlyphName("Adieresis")
    public static let Agrave = ISO.`32000`.GlyphName("Agrave")
    public static let Aring = ISO.`32000`.GlyphName("Aring")
    public static let Atilde = ISO.`32000`.GlyphName("Atilde")
    public static let AE = ISO.`32000`.GlyphName("AE")
    public static let Ccedilla = ISO.`32000`.GlyphName("Ccedilla")
    public static let Eacute = ISO.`32000`.GlyphName("Eacute")
    public static let Ecircumflex = ISO.`32000`.GlyphName("Ecircumflex")
    public static let Edieresis = ISO.`32000`.GlyphName("Edieresis")
    public static let Egrave = ISO.`32000`.GlyphName("Egrave")
    public static let Eth = ISO.`32000`.GlyphName("Eth")
    public static let Iacute = ISO.`32000`.GlyphName("Iacute")
    public static let Icircumflex = ISO.`32000`.GlyphName("Icircumflex")
    public static let Idieresis = ISO.`32000`.GlyphName("Idieresis")
    public static let Igrave = ISO.`32000`.GlyphName("Igrave")
    public static let Ntilde = ISO.`32000`.GlyphName("Ntilde")
    public static let Oacute = ISO.`32000`.GlyphName("Oacute")
    public static let Ocircumflex = ISO.`32000`.GlyphName("Ocircumflex")
    public static let Odieresis = ISO.`32000`.GlyphName("Odieresis")
    public static let Ograve = ISO.`32000`.GlyphName("Ograve")
    public static let Oslash = ISO.`32000`.GlyphName("Oslash")
    public static let Otilde = ISO.`32000`.GlyphName("Otilde")
    public static let OE = ISO.`32000`.GlyphName("OE")
    public static let Scaron = ISO.`32000`.GlyphName("Scaron")
    public static let Thorn = ISO.`32000`.GlyphName("Thorn")
    public static let Uacute = ISO.`32000`.GlyphName("Uacute")
    public static let Ucircumflex = ISO.`32000`.GlyphName("Ucircumflex")
    public static let Udieresis = ISO.`32000`.GlyphName("Udieresis")
    public static let Ugrave = ISO.`32000`.GlyphName("Ugrave")
    public static let Yacute = ISO.`32000`.GlyphName("Yacute")
    public static let Ydieresis = ISO.`32000`.GlyphName("Ydieresis")
    public static let Zcaron = ISO.`32000`.GlyphName("Zcaron")
    public static let Lslash = ISO.`32000`.GlyphName("Lslash")

    public static let aacute = ISO.`32000`.GlyphName("aacute")
    public static let acircumflex = ISO.`32000`.GlyphName("acircumflex")
    public static let adieresis = ISO.`32000`.GlyphName("adieresis")
    public static let agrave = ISO.`32000`.GlyphName("agrave")
    public static let aring = ISO.`32000`.GlyphName("aring")
    public static let atilde = ISO.`32000`.GlyphName("atilde")
    public static let ae = ISO.`32000`.GlyphName("ae")
    public static let ccedilla = ISO.`32000`.GlyphName("ccedilla")
    public static let eacute = ISO.`32000`.GlyphName("eacute")
    public static let ecircumflex = ISO.`32000`.GlyphName("ecircumflex")
    public static let edieresis = ISO.`32000`.GlyphName("edieresis")
    public static let egrave = ISO.`32000`.GlyphName("egrave")
    public static let eth = ISO.`32000`.GlyphName("eth")
    public static let iacute = ISO.`32000`.GlyphName("iacute")
    public static let icircumflex = ISO.`32000`.GlyphName("icircumflex")
    public static let idieresis = ISO.`32000`.GlyphName("idieresis")
    public static let igrave = ISO.`32000`.GlyphName("igrave")
    public static let ntilde = ISO.`32000`.GlyphName("ntilde")
    public static let oacute = ISO.`32000`.GlyphName("oacute")
    public static let ocircumflex = ISO.`32000`.GlyphName("ocircumflex")
    public static let odieresis = ISO.`32000`.GlyphName("odieresis")
    public static let ograve = ISO.`32000`.GlyphName("ograve")
    public static let oslash = ISO.`32000`.GlyphName("oslash")
    public static let otilde = ISO.`32000`.GlyphName("otilde")
    public static let oe = ISO.`32000`.GlyphName("oe")
    public static let scaron = ISO.`32000`.GlyphName("scaron")
    public static let thorn = ISO.`32000`.GlyphName("thorn")
    public static let uacute = ISO.`32000`.GlyphName("uacute")
    public static let ucircumflex = ISO.`32000`.GlyphName("ucircumflex")
    public static let udieresis = ISO.`32000`.GlyphName("udieresis")
    public static let ugrave = ISO.`32000`.GlyphName("ugrave")
    public static let yacute = ISO.`32000`.GlyphName("yacute")
    public static let ydieresis = ISO.`32000`.GlyphName("ydieresis")
    public static let zcaron = ISO.`32000`.GlyphName("zcaron")
    public static let lslash = ISO.`32000`.GlyphName("lslash")
    public static let germandbls = ISO.`32000`.GlyphName("germandbls")
    public static let dotlessi = ISO.`32000`.GlyphName("dotlessi")

    public static let acute = ISO.`32000`.GlyphName("acute")
    public static let breve = ISO.`32000`.GlyphName("breve")
    public static let caron = ISO.`32000`.GlyphName("caron")
    public static let cedilla = ISO.`32000`.GlyphName("cedilla")
    public static let circumflex = ISO.`32000`.GlyphName("circumflex")
    public static let dieresis = ISO.`32000`.GlyphName("dieresis")
    public static let dotaccent = ISO.`32000`.GlyphName("dotaccent")
    public static let hungarumlaut = ISO.`32000`.GlyphName("hungarumlaut")
    public static let macron = ISO.`32000`.GlyphName("macron")
    public static let ogonek = ISO.`32000`.GlyphName("ogonek")
    public static let ring = ISO.`32000`.GlyphName("ring")
    public static let tilde = ISO.`32000`.GlyphName("tilde")

    public static let onehalf = ISO.`32000`.GlyphName("onehalf")
    public static let onequarter = ISO.`32000`.GlyphName("onequarter")
    public static let threequarters = ISO.`32000`.GlyphName("threequarters")
    public static let onesuperior = ISO.`32000`.GlyphName("onesuperior")
    public static let twosuperior = ISO.`32000`.GlyphName("twosuperior")
    public static let threesuperior = ISO.`32000`.GlyphName("threesuperior")
    public static let fraction = ISO.`32000`.GlyphName("fraction")
    public static let plusminus = ISO.`32000`.GlyphName("plusminus")
    public static let multiply = ISO.`32000`.GlyphName("multiply")
    public static let divide = ISO.`32000`.GlyphName("divide")
    public static let minus = ISO.`32000`.GlyphName("minus")
    public static let degree = ISO.`32000`.GlyphName("degree")
    public static let mu = ISO.`32000`.GlyphName("mu")
    public static let logicalnot = ISO.`32000`.GlyphName("logicalnot")

    public static let copyright = ISO.`32000`.GlyphName("copyright")
    public static let registered = ISO.`32000`.GlyphName("registered")
    public static let trademark = ISO.`32000`.GlyphName("trademark")
    public static let section = ISO.`32000`.GlyphName("section")
    public static let paragraph = ISO.`32000`.GlyphName("paragraph")
    public static let brokenbar = ISO.`32000`.GlyphName("brokenbar")
    public static let ordfeminine = ISO.`32000`.GlyphName("ordfeminine")
    public static let ordmasculine = ISO.`32000`.GlyphName("ordmasculine")
    public static let exclamdown = ISO.`32000`.GlyphName("exclamdown")
    public static let questiondown = ISO.`32000`.GlyphName("questiondown")
    public static let periodcentered = ISO.`32000`.GlyphName("periodcentered")
}
