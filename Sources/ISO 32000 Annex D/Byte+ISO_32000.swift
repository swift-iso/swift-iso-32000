public import Byte_Primitives
public import ISO_32000_Shared

extension Byte {

    @frozen
    public struct WinAnsi: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var winAnsi: WinAnsi {
        WinAnsi(self)
    }
}

extension Byte.WinAnsi {

    public protocol Serializable: Sendable {

        associatedtype Error: Swift.Error

        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            winAnsi bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            winAnsi serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.WinAnsi.Serializable where Context == Void {

    @inlinable
    public init<Bytes: Collection>(winAnsi bytes: Bytes) throws(Error)
    where Bytes.Element == Byte {
        try self.init(winAnsi: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(winAnsi string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.WinAnsiEncoding.self)
    }

    @inlinable
    public init(
        winAnsi string: some StringProtocol,
        withFallback: Bool,
        preservingControlChars: Bool = false
    ) {
        self.init(
            string,
            encoding: ISO_32000.WinAnsiEncoding.self,
            withFallback: withFallback,
            preservingControlChars: preservingControlChars
        )
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(winAnsi bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.WinAnsiEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(winAnsi bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.WinAnsiEncoding.self, withReplacement: withReplacement)
    }
}

extension Byte {

    @frozen
    public struct PDFDoc: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var pdfDoc: PDFDoc {
        PDFDoc(self)
    }
}

extension Byte.PDFDoc {

    public protocol Serializable: Sendable {
        associatedtype Error: Swift.Error
        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            pdfDoc bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            pdfDoc serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.PDFDoc.Serializable where Context == Void {
    @inlinable
    public init<Bytes: Collection>(pdfDoc bytes: Bytes) throws(Error) where Bytes.Element == Byte {
        try self.init(pdfDoc: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(pdfDoc string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.PDFDocEncoding.self)
    }

    @inlinable
    public init(pdfDoc string: some StringProtocol, withFallback: Bool) {
        self.init(string, encoding: ISO_32000.PDFDocEncoding.self, withFallback: withFallback)
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(pdfDoc bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.PDFDocEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(pdfDoc bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.PDFDocEncoding.self, withReplacement: withReplacement)
    }
}

extension Byte {

    @frozen
    public struct Standard: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var standard: Standard {
        Standard(self)
    }
}

extension Byte.Standard {

    public protocol Serializable: Sendable {
        associatedtype Error: Swift.Error
        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            standard bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            standard serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.Standard.Serializable where Context == Void {
    @inlinable
    public init<Bytes: Collection>(
        standard bytes: Bytes
    ) throws(Error) where Bytes.Element == Byte {
        try self.init(standard: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(standard string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.StandardEncoding.self)
    }

    @inlinable
    public init(standard string: some StringProtocol, withFallback: Bool) {
        self.init(string, encoding: ISO_32000.StandardEncoding.self, withFallback: withFallback)
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(standard bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.StandardEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(standard bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(
            bytes,
            encoding: ISO_32000.StandardEncoding.self,
            withReplacement: withReplacement
        )
    }
}

extension Byte {

    @frozen
    public struct MacRoman: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var macRoman: MacRoman {
        MacRoman(self)
    }
}

extension Byte.MacRoman {

    public protocol Serializable: Sendable {
        associatedtype Error: Swift.Error
        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            macRoman bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            macRoman serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.MacRoman.Serializable where Context == Void {
    @inlinable
    public init<Bytes: Collection>(macRoman bytes: Bytes) throws(Error)
    where Bytes.Element == Byte {
        try self.init(macRoman: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(macRoman string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.MacRomanEncoding.self)
    }

    @inlinable
    public init(macRoman string: some StringProtocol, withFallback: Bool) {
        self.init(string, encoding: ISO_32000.MacRomanEncoding.self, withFallback: withFallback)
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(macRoman bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.MacRomanEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(macRoman bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(
            bytes,
            encoding: ISO_32000.MacRomanEncoding.self,
            withReplacement: withReplacement
        )
    }
}

extension Byte {

    @frozen
    public struct Symbol: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var symbol: Symbol {
        Symbol(self)
    }
}

extension Byte.Symbol {

    public protocol Serializable: Sendable {
        associatedtype Error: Swift.Error
        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            symbol bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            symbol serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.Symbol.Serializable where Context == Void {
    @inlinable
    public init<Bytes: Collection>(symbol bytes: Bytes) throws(Error) where Bytes.Element == Byte {
        try self.init(symbol: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(symbol string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.SymbolEncoding.self)
    }

    @inlinable
    public init(symbol string: some StringProtocol, withFallback: Bool) {
        self.init(string, encoding: ISO_32000.SymbolEncoding.self, withFallback: withFallback)
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(symbol bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.SymbolEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(symbol bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.SymbolEncoding.self, withReplacement: withReplacement)
    }
}

extension Byte {

    @frozen
    public struct ZapfDingbats: Sendable {
        public let byte: Byte

        @inlinable
        public init(_ byte: Byte) {
            self.byte = byte
        }
    }

    @inlinable
    public var zapfDingbats: ZapfDingbats {
        ZapfDingbats(self)
    }
}

extension Byte.ZapfDingbats {

    public protocol Serializable: Sendable {
        associatedtype Error: Swift.Error
        associatedtype Context: Sendable = Void

        init<Bytes: Collection>(
            zapfDingbats bytes: Bytes,
            in context: Context
        ) throws(Error) where Bytes.Element == Byte

        static func serialize<Buffer: RangeReplaceableCollection>(
            zapfDingbats serializable: Self,
            into buffer: inout Buffer
        ) where Buffer.Element == Byte
    }

    public protocol RawRepresentable: Serializable, Swift.RawRepresentable {}
}

extension Byte.ZapfDingbats.Serializable where Context == Void {
    @inlinable
    public init<Bytes: Collection>(zapfDingbats bytes: Bytes) throws(Error)
    where Bytes.Element == Byte {
        try self.init(zapfDingbats: bytes, in: ())
    }
}

extension Array where Element == Byte {

    @inlinable
    public init?(zapfDingbats string: some StringProtocol) {
        self.init(string, encoding: ISO_32000.ZapfDingbatsEncoding.self)
    }

    @inlinable
    public init(zapfDingbats string: some StringProtocol, withFallback: Bool) {
        self.init(string, encoding: ISO_32000.ZapfDingbatsEncoding.self, withFallback: withFallback)
    }
}

extension String {

    @inlinable
    public init?<Bytes: Collection>(zapfDingbats bytes: Bytes) where Bytes.Element == Byte {
        self.init(bytes, encoding: ISO_32000.ZapfDingbatsEncoding.self)
    }

    @inlinable
    public init<Bytes: Collection>(zapfDingbats bytes: Bytes, withReplacement: Bool)
    where Bytes.Element == Byte {
        self.init(
            bytes,
            encoding: ISO_32000.ZapfDingbatsEncoding.self,
            withReplacement: withReplacement
        )
    }
}

extension Byte.WinAnsi {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.WinAnsiEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.WinAnsiEncoding.decode(byte) != nil
    }
}

extension Byte.WinAnsi {

    public static let euro: Byte = 0x80

    public static let quotesinglbase: Byte = 0x82

    public static let florin: Byte = 0x83

    public static let quotedblbase: Byte = 0x84

    public static let ellipsis: Byte = 0x85

    public static let dagger: Byte = 0x86

    public static let daggerdbl: Byte = 0x87

    public static let circumflex: Byte = 0x88

    public static let perthousand: Byte = 0x89

    public static let Scaron: Byte = 0x8A

    public static let guilsinglleft: Byte = 0x8B

    public static let OE: Byte = 0x8C

    public static let Zcaron: Byte = 0x8E

    public static let quoteleft: Byte = 0x91

    public static let quoteright: Byte = 0x92

    public static let quotedblleft: Byte = 0x93

    public static let quotedblright: Byte = 0x94

    public static let bullet: Byte = 0x95

    public static let endash: Byte = 0x96

    public static let emdash: Byte = 0x97

    public static let tilde: Byte = 0x98

    public static let trademark: Byte = 0x99

    public static let scaron: Byte = 0x9A

    public static let guilsinglright: Byte = 0x9B

    public static let oe: Byte = 0x9C

    public static let zcaron: Byte = 0x9E

    public static let Ydieresis: Byte = 0x9F

    public static let nbsp: Byte = 0xA0

    public static let exclamdown: Byte = 0xA1

    public static let cent: Byte = 0xA2

    public static let sterling: Byte = 0xA3

    public static let currency: Byte = 0xA4

    public static let yen: Byte = 0xA5

    public static let section: Byte = 0xA7

    public static let copyright: Byte = 0xA9

    public static let guillemotleft: Byte = 0xAB

    public static let registered: Byte = 0xAE

    public static let degree: Byte = 0xB0

    public static let plusminus: Byte = 0xB1

    public static let paragraph: Byte = 0xB6

    public static let periodcentered: Byte = 0xB7

    public static let guillemotright: Byte = 0xBB

    public static let onequarter: Byte = 0xBC

    public static let onehalf: Byte = 0xBD

    public static let threequarters: Byte = 0xBE

    public static let questiondown: Byte = 0xBF

    public static let multiply: Byte = 0xD7

    public static let divide: Byte = 0xF7
}

extension Byte.PDFDoc {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.PDFDocEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.PDFDocEncoding.decode(byte) != nil
    }
}

extension Byte.PDFDoc {

    public static let breve: Byte = 0x18

    public static let caron: Byte = 0x19

    public static let circumflex: Byte = 0x1A

    public static let dotaccent: Byte = 0x1B

    public static let hungarumlaut: Byte = 0x1C

    public static let ogonek: Byte = 0x1D

    public static let ring: Byte = 0x1E

    public static let tilde: Byte = 0x1F

    public static let bullet: Byte = 0x80

    public static let dagger: Byte = 0x81

    public static let daggerdbl: Byte = 0x82

    public static let ellipsis: Byte = 0x83

    public static let emdash: Byte = 0x84

    public static let endash: Byte = 0x85

    public static let florin: Byte = 0x86

    public static let fraction: Byte = 0x87

    public static let guilsinglleft: Byte = 0x88

    public static let guilsinglright: Byte = 0x89

    public static let minus: Byte = 0x8A

    public static let perthousand: Byte = 0x8B

    public static let quotesinglbase: Byte = 0x8C

    public static let quotedblbase: Byte = 0x8D

    public static let quotedblleft: Byte = 0x8E

    public static let quotedblright: Byte = 0x8F

    public static let quoteleft: Byte = 0x90

    public static let quoteright: Byte = 0x91

    public static let trademark: Byte = 0x95

    public static let fi: Byte = 0x96

    public static let fl: Byte = 0x97

    public static let OE: Byte = 0x9A

    public static let Scaron: Byte = 0x9B

    public static let Ydieresis: Byte = 0x9C

    public static let oe: Byte = 0x9E

    public static let scaron: Byte = 0x9F

    public static let euro: Byte = 0xA0
}

extension Byte.Standard {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.StandardEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.StandardEncoding.decode(byte) != nil
    }
}

extension Byte.Standard {

    public static let quoteright: Byte = 0x27

    public static let quoteleft: Byte = 0x60

    public static let fi: Byte = 0xAE

    public static let fl: Byte = 0xAF

    public static let fraction: Byte = 0xA4

    public static let emdash: Byte = 0xD0

    public static let endash: Byte = 0xB1
}

extension Byte.MacRoman {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.MacRomanEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.MacRomanEncoding.decode(byte) != nil
    }
}

extension Byte.MacRoman {

    public static let currency: Byte = 0xDB

    public static let nbsp: Byte = 0xCA

    public static let fi: Byte = 0xDE

    public static let fl: Byte = 0xDF
}

extension Byte.Symbol {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.SymbolEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.SymbolEncoding.decode(byte) != nil
    }
}

extension Byte.Symbol {

    public static let Alpha: Byte = 0x41

    public static let Beta: Byte = 0x42

    public static let Gamma: Byte = 0x47

    public static let Delta: Byte = 0x44

    public static let Omega: Byte = 0x57

    public static let alpha: Byte = 0x61

    public static let beta: Byte = 0x62

    public static let gamma: Byte = 0x67

    public static let delta: Byte = 0x64

    public static let pi: Byte = 0x70

    public static let omega: Byte = 0x77

    public static let infinity: Byte = 0xA5

    public static let plusminus: Byte = 0xB1

    public static let multiply: Byte = 0xB4

    public static let divide: Byte = 0xB8

    public static let notequal: Byte = 0xB9

    public static let lessequal: Byte = 0xA3

    public static let greaterequal: Byte = 0xB3

    public static let intersection: Byte = 0xC7

    public static let union: Byte = 0xC8

    public static let element: Byte = 0xCE

    public static let notelement: Byte = 0xCF
}

extension Byte.ZapfDingbats {

    @inlinable
    public var decoded: Unicode.Scalar? {
        ISO_32000.ZapfDingbatsEncoding.decode(byte)
    }

    @inlinable
    public var isDefined: Bool {
        ISO_32000.ZapfDingbatsEncoding.decode(byte) != nil
    }
}

extension Byte.ZapfDingbats {

    public static let scissors: Byte = 0x21

    public static let writingHand: Byte = 0x2A

    public static let checkmark: Byte = 0x33

    public static let ballotX: Byte = 0x37

    public static let blackStar: Byte = 0x48

    public static let whiteStar: Byte = 0x49

    public static let club: Byte = 0xAB

    public static let diamond: Byte = 0xAC

    public static let heart: Byte = 0xAD

    public static let spade: Byte = 0xAE

    public static let arrowRight: Byte = 0xD5
}
