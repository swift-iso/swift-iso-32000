public import ASCII_Primitives
internal import Binary_Endianness_Primitives
public import Binary_Primitives
internal import Binary_Primitives_Standard_Library_Integration
public import Binary_Serializable_Primitives
public import Format_Primitives
import Formatter_Primitives
import IEEE_754
import ISO_32000_Annex_D
public import ISO_32000_Shared
import Standard_Library_Extensions

extension ISO_32000.`7` {

    public enum `3` {}
}

extension ISO_32000.`7`.`3` {
    public enum Table {}
}

extension ISO_32000.`7`.`3`.Table {

    public enum `3` {}
}

extension ISO_32000.`7`.`3`.Table.`3` {

    public static let escapeTable: [Byte: [Byte]] = [
        .ascii.lf: [.ascii.backslash, .ascii.n],
        .ascii.cr: [.ascii.backslash, .ascii.r],
        .ascii.htab: [.ascii.backslash, .ascii.t],
        .ascii.bs: [.ascii.backslash, .ascii.b],
        .ascii.ff: [.ascii.backslash, .ascii.f],
        .ascii.leftParenthesis: [.ascii.backslash, .ascii.leftParenthesis],
        .ascii.rightParenthesis: [.ascii.backslash, .ascii.rightParenthesis],
        .ascii.backslash: [.ascii.backslash, .ascii.backslash],
    ]

    @usableFromInline
    internal static let escapeCharLookup: [Byte] = {
        var table = [Byte](repeating: 0, count: 256)
        table[Int(UInt8.ascii.lf)] = .ascii.n
        table[Int(UInt8.ascii.cr)] = .ascii.r
        table[Int(UInt8.ascii.htab)] = .ascii.t
        table[Int(UInt8.ascii.bs)] = .ascii.b
        table[Int(UInt8.ascii.ff)] = .ascii.f
        table[Int(UInt8.ascii.leftParenthesis)] = .ascii.leftParenthesis
        table[Int(UInt8.ascii.rightParenthesis)] = .ascii.rightParenthesis
        table[Int(UInt8.ascii.backslash)] = .ascii.backslash
        return table
    }()

    @inlinable
    public static func serializeLiteralString<
        Bytes: Collection,
        Buffer: RangeReplaceableCollection
    >(
        _ bytes: Bytes,
        into buffer: inout Buffer
    ) where Bytes.Element == Byte, Buffer.Element == Byte {
        buffer.append(.ascii.leftParenthesis)
        for byte in bytes {
            let escapeChar = escapeCharLookup[Int(byte.underlying)]
            if escapeChar != 0 {
                buffer.append(.ascii.backslash)
                buffer.append(escapeChar)
            } else {
                buffer.append(byte)
            }
        }
        buffer.append(.ascii.rightParenthesis)
    }

    @inlinable
    public static func literalString<Bytes: Collection>(
        from bytes: Bytes
    ) -> [Byte] where Bytes.Element == Byte {
        var result: [Byte] = []
        result.reserveCapacity(bytes.count + 2)
        serializeLiteralString(bytes, into: &result)
        return result
    }
}

extension ISO_32000.`7`.`3` {

    public enum `3` {}
}

extension ISO_32000.`7`.`3`.`3` {

    public struct RealFormatStyle: Formatter.`Protocol`, Sendable {
        public init() {}
    }
}

extension ISO_32000.`7`.`3`.`3`.RealFormatStyle {
    public typealias Input = Double
    public typealias Output = String
    public typealias Failure = Never

    public func format(_ value: Double) -> String {
        var bytes: [Byte] = []
        ISO_32000.`7`.`3`.`3`.PDFNumber.serializeReal(value, into: &bytes)
        return String(decoding: bytes, as: UTF8.self)
    }
}

extension Formatter.`Protocol` where Self == ISO_32000.`7`.`3`.`3`.RealFormatStyle {

    public static var pdf: ISO_32000.`7`.`3`.`3`.RealFormatStyle {
        ISO_32000.`7`.`3`.`3`.RealFormatStyle()
    }
}

extension ISO_32000.`7`.`3` {

    public enum `5` {}
}

extension ISO_32000.`7`.`3`.`5` {

    public struct Name: Sendable, Hashable {

        public let rawValue: String

        @usableFromInline
        init(
            __unchecked: Void,
            rawValue: String
        ) {
            self.rawValue = rawValue
        }

        public init(_ rawValue: String) throws(Error) {
            guard !rawValue.isEmpty else {
                throw .empty
            }

            guard rawValue.utf8.count <= Limits.maxLength else {
                throw .tooLong(rawValue.utf8.count)
            }

            for byte in rawValue.utf8 {
                if byte == 0x00 {
                    throw .containsNullByte
                }
                if byte.ascii.isWhitespace {
                    throw .containsWhitespace
                }
            }

            self.init(__unchecked: (), rawValue: rawValue)
        }
    }
}

extension ISO_32000.`7`.`3`.`5`.Name {

    package enum Limits {}
}

extension ISO_32000.`7`.`3`.`5`.Name.Limits {

    static let maxLength = 127
}

#if !hasFeature(Embedded)
    extension ISO_32000.`7`.`3`.`5`.Name: Codable {}
#endif

extension ISO_32000.`7`.`3`.`5`.Name {
    @inlinable
    public static var f1: Self {
        .init(
            __unchecked: (),
            rawValue: "F1"
        )
    }

    @inlinable
    public static var f2: Self {
        .init(
            __unchecked: (),
            rawValue: "F2"
        )
    }
    @inlinable
    public static var f3: Self {
        .init(
            __unchecked: (),
            rawValue: "F3"
        )
    }
    @inlinable
    public static var f4: Self {
        .init(
            __unchecked: (),
            rawValue: "F4"
        )
    }
    @inlinable
    public static var f5: Self {
        .init(
            __unchecked: (),
            rawValue: "F5"
        )
    }
    @inlinable
    public static var f6: Self {
        .init(
            __unchecked: (),
            rawValue: "F6"
        )
    }
    @inlinable
    public static var f7: Self {
        .init(
            __unchecked: (),
            rawValue: "F7"
        )
    }
    @inlinable
    public static var f8: Self {
        .init(
            __unchecked: (),
            rawValue: "F8"
        )
    }
    @inlinable
    public static var f9: Self {
        .init(
            __unchecked: (),
            rawValue: "F9"
        )
    }
    @inlinable
    public static var f10: Self {
        .init(
            __unchecked: (),
            rawValue: "F10"
        )
    }
    @inlinable
    public static var f11: Self {
        .init(
            __unchecked: (),
            rawValue: "F11"
        )
    }
    @inlinable
    public static var f12: Self {
        .init(
            __unchecked: (),
            rawValue: "F12"
        )
    }
    @inlinable
    public static var f13: Self {
        .init(
            __unchecked: (),
            rawValue: "F13"
        )
    }
    @inlinable
    public static var f14: Self {
        .init(
            __unchecked: (),
            rawValue: "F14"
        )
    }
}

extension ISO_32000.`7`.`3`.`5`.Name {
    public enum Error: Swift.Error, Sendable, Equatable {
        case empty
        case tooLong(_ byteCount: Int)
        case containsNullByte
        case containsWhitespace
    }
}

extension ISO_32000.`7`.`3`.`5`.Name.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty:
            return "Name cannot be empty"

        case .tooLong(let count):
            return
                "Name too long: \(count) bytes (max \(ISO_32000.`7`.`3`.`5`.Name.Limits.maxLength))"

        case .containsNullByte:
            return "Name cannot contain null bytes"

        case .containsWhitespace:
            return "Name cannot contain whitespace"
        }
    }
}

extension ISO_32000.`7`.`3`.`5`.Name: CustomStringConvertible {
    public var description: String {
        "/\(rawValue)"
    }
}

extension ISO_32000.`7`.`3`.`5`.Name {

    public static let type = Self(__unchecked: (), rawValue: "Type")
    public static let catalog = Self(__unchecked: (), rawValue: "Catalog")
    public static let pages = Self(__unchecked: (), rawValue: "Pages")
    public static let page = Self(__unchecked: (), rawValue: "Page")
    public static let outlines = Self(__unchecked: (), rawValue: "Outlines")

    public static let first = Self(__unchecked: (), rawValue: "First")
    public static let last = Self(__unchecked: (), rawValue: "Last")
    public static let next = Self(__unchecked: (), rawValue: "Next")
    public static let prev = Self(__unchecked: (), rawValue: "Prev")
    public static let dest = Self(__unchecked: (), rawValue: "Dest")

    public static let xyz = Self(__unchecked: (), rawValue: "XYZ")
    public static let fit = Self(__unchecked: (), rawValue: "Fit")
    public static let fitH = Self(__unchecked: (), rawValue: "FitH")
    public static let fitV = Self(__unchecked: (), rawValue: "FitV")
    public static let fitR = Self(__unchecked: (), rawValue: "FitR")
    public static let fitB = Self(__unchecked: (), rawValue: "FitB")
    public static let fitBH = Self(__unchecked: (), rawValue: "FitBH")
    public static let fitBV = Self(__unchecked: (), rawValue: "FitBV")

    public static let parent = Self(__unchecked: (), rawValue: "Parent")
    public static let kids = Self(__unchecked: (), rawValue: "Kids")
    public static let count = Self(__unchecked: (), rawValue: "Count")
    public static let mediaBox = Self(__unchecked: (), rawValue: "MediaBox")
    public static let cropBox = Self(__unchecked: (), rawValue: "CropBox")
    public static let contents = Self(__unchecked: (), rawValue: "Contents")
    public static let resources = Self(__unchecked: (), rawValue: "Resources")
    public static let rotate = Self(__unchecked: (), rawValue: "Rotate")

    public static let font = Self(__unchecked: (), rawValue: "Font")
    public static let xObject = Self(__unchecked: (), rawValue: "XObject")
    public static let extGState = Self(__unchecked: (), rawValue: "ExtGState")
    public static let procSet = Self(__unchecked: (), rawValue: "ProcSet")

    public static let subtype = Self(__unchecked: (), rawValue: "Subtype")
    public static let type1 = Self(__unchecked: (), rawValue: "Type1")
    public static let trueType = Self(__unchecked: (), rawValue: "TrueType")
    public static let baseFont = Self(__unchecked: (), rawValue: "BaseFont")
    public static let encoding = Self(__unchecked: (), rawValue: "Encoding")
    public static let winAnsiEncoding = Self(__unchecked: (), rawValue: "WinAnsiEncoding")

    public static let length = Self(__unchecked: (), rawValue: "Length")
    public static let filter = Self(__unchecked: (), rawValue: "Filter")
    public static let flateDecode = Self(__unchecked: (), rawValue: "FlateDecode")
    public static let decodeParms = Self(__unchecked: (), rawValue: "DecodeParms")

    public static let image = Self(__unchecked: (), rawValue: "Image")
    public static let width = Self(__unchecked: (), rawValue: "Width")
    public static let height = Self(__unchecked: (), rawValue: "Height")
    public static let colorSpace = Self(__unchecked: (), rawValue: "ColorSpace")
    public static let bitsPerComponent = Self(__unchecked: (), rawValue: "BitsPerComponent")
    public static let dctDecode = Self(__unchecked: (), rawValue: "DCTDecode")

    public static let deviceRGB = Self(__unchecked: (), rawValue: "DeviceRGB")
    public static let deviceGray = Self(__unchecked: (), rawValue: "DeviceGray")
    public static let deviceCMYK = Self(__unchecked: (), rawValue: "DeviceCMYK")

    public static let helvetica = Self(__unchecked: (), rawValue: "Helvetica")
    public static let helveticaBold = Self(__unchecked: (), rawValue: "Helvetica-Bold")
    public static let helveticaOblique = Self(__unchecked: (), rawValue: "Helvetica-Oblique")
    public static let helveticaBoldOblique = Self(
        __unchecked: (),
        rawValue: "Helvetica-BoldOblique"
    )
    public static let timesRoman = Self(__unchecked: (), rawValue: "Times-Roman")
    public static let timesBold = Self(__unchecked: (), rawValue: "Times-Bold")
    public static let timesItalic = Self(__unchecked: (), rawValue: "Times-Italic")
    public static let timesBoldItalic = Self(__unchecked: (), rawValue: "Times-BoldItalic")
    public static let courier = Self(__unchecked: (), rawValue: "Courier")
    public static let courierBold = Self(__unchecked: (), rawValue: "Courier-Bold")
    public static let courierOblique = Self(__unchecked: (), rawValue: "Courier-Oblique")
    public static let courierBoldOblique = Self(__unchecked: (), rawValue: "Courier-BoldOblique")
    public static let symbol = Self(__unchecked: (), rawValue: "Symbol")
    public static let zapfDingbats = Self(__unchecked: (), rawValue: "ZapfDingbats")

    public static let fontDescriptor = Self(__unchecked: (), rawValue: "FontDescriptor")

    public static let fontName = Self(__unchecked: (), rawValue: "FontName")
    public static let fontFlags = Self(__unchecked: (), rawValue: "Flags")
    public static let fontBBox = Self(__unchecked: (), rawValue: "FontBBox")
    public static let italicAngle = Self(__unchecked: (), rawValue: "ItalicAngle")
    public static let ascent = Self(__unchecked: (), rawValue: "Ascent")
    public static let descent = Self(__unchecked: (), rawValue: "Descent")
    public static let leading = Self(__unchecked: (), rawValue: "Leading")
    public static let capHeight = Self(__unchecked: (), rawValue: "CapHeight")
    public static let xHeight = Self(__unchecked: (), rawValue: "XHeight")
    public static let stemV = Self(__unchecked: (), rawValue: "StemV")
    public static let stemH = Self(__unchecked: (), rawValue: "StemH")
    public static let missingWidth = Self(__unchecked: (), rawValue: "MissingWidth")
    public static let fontFile2 = Self(__unchecked: (), rawValue: "FontFile2")
    public static let firstChar = Self(__unchecked: (), rawValue: "FirstChar")
    public static let lastChar = Self(__unchecked: (), rawValue: "LastChar")
    public static let widths = Self(__unchecked: (), rawValue: "Widths")
    public static let length1 = Self(__unchecked: (), rawValue: "Length1")
    public static let toUnicode = Self(__unchecked: (), rawValue: "ToUnicode")

    public static let pdf = Self(__unchecked: (), rawValue: "PDF")
    public static let text = Self(__unchecked: (), rawValue: "Text")
    public static let imageb = Self(__unchecked: (), rawValue: "ImageB")
    public static let imagec = Self(__unchecked: (), rawValue: "ImageC")
    public static let imagei = Self(__unchecked: (), rawValue: "ImageI")

    public static let title = Self(__unchecked: (), rawValue: "Title")
    public static let author = Self(__unchecked: (), rawValue: "Author")
    public static let subject = Self(__unchecked: (), rawValue: "Subject")
    public static let keywords = Self(__unchecked: (), rawValue: "Keywords")
    public static let creator = Self(__unchecked: (), rawValue: "Creator")
    public static let producer = Self(__unchecked: (), rawValue: "Producer")
    public static let creationDate = Self(__unchecked: (), rawValue: "CreationDate")
    public static let modDate = Self(__unchecked: (), rawValue: "ModDate")

    public static let size = Self(__unchecked: (), rawValue: "Size")
    public static let root = Self(__unchecked: (), rawValue: "Root")
    public static let info = Self(__unchecked: (), rawValue: "Info")

    public static let annots = Self(__unchecked: (), rawValue: "Annots")
    public static let annot = Self(__unchecked: (), rawValue: "Annot")
    public static let link = Self(__unchecked: (), rawValue: "Link")
    public static let rect = Self(__unchecked: (), rawValue: "Rect")
    public static let border = Self(__unchecked: (), rawValue: "Border")
    public static let a = Self(__unchecked: (), rawValue: "A")
    public static let s = Self(__unchecked: (), rawValue: "S")
    public static let uri = Self(__unchecked: (), rawValue: "URI")

    public static let table = Self(__unchecked: (), rawValue: "Table")
    public static let tr = Self(__unchecked: (), rawValue: "TR")
    public static let th = Self(__unchecked: (), rawValue: "TH")
    public static let td = Self(__unchecked: (), rawValue: "TD")
    public static let thead = Self(__unchecked: (), rawValue: "THead")
    public static let tbody = Self(__unchecked: (), rawValue: "TBody")
    public static let tfoot = Self(__unchecked: (), rawValue: "TFoot")

    public static let caption = Self(__unchecked: (), rawValue: "Caption")

    public static let rowSpan = Self(__unchecked: (), rawValue: "RowSpan")
    public static let colSpan = Self(__unchecked: (), rawValue: "ColSpan")
    public static let headers = Self(__unchecked: (), rawValue: "Headers")
    public static let scope = Self(__unchecked: (), rawValue: "Scope")
    public static let summary = Self(__unchecked: (), rawValue: "Summary")
    public static let short = Self(__unchecked: (), rawValue: "Short")

    public static let row = Self(__unchecked: (), rawValue: "Row")
    public static let column = Self(__unchecked: (), rawValue: "Column")
    public static let both = Self(__unchecked: (), rawValue: "Both")

    public static let span = Self(__unchecked: (), rawValue: "Span")
    public static let actualText = Self(__unchecked: (), rawValue: "ActualText")
}

extension ISO_32000.`7`.`3` {

    public enum `8` {}
}

extension ISO_32000.`7`.`3`.`8` {

    public struct Stream: Sendable, Hashable {

        public var dictionary: ISO_32000.`7`.`3`.COS.Dictionary

        public var data: [Byte]

        public init(dictionary: ISO_32000.`7`.`3`.COS.Dictionary = [:], data: [Byte] = []) {
            self.dictionary = dictionary
            self.data = data
        }

        public init(data: [Byte]) {
            self.dictionary = [:]
            self.data = data
        }
    }
}

extension ISO_32000.`7`.`3`.`8`.Stream: CustomStringConvertible {
    public var description: String {
        "\(dictionary) stream<\(data.count) bytes>"
    }
}

extension ISO_32000.`7`.`3` {

    public enum `10` {}
}

extension ISO_32000.`7`.`3`.`10` {

    public struct IndirectReference: Sendable, Hashable {

        public let objectNumber: Int

        public let generation: Int

        public init(objectNumber: Int, generation: Int = 0) {
            self.objectNumber = objectNumber
            self.generation = generation
        }
    }
}

#if !hasFeature(Embedded)
    extension ISO_32000.`7`.`3`.`10`.IndirectReference: Codable {}
#endif

extension ISO_32000.`7`.`3`.`10`.IndirectReference: CustomStringConvertible {
    public var description: String {
        "\(objectNumber) \(generation) R"
    }
}

extension ISO_32000.`7`.`3` {

    public enum CarouselObjectSystem {}
}

extension ISO_32000.`7`.`3` {
    public typealias COS = CarouselObjectSystem
}

extension ISO_32000.`7`.`3`.COS {

    public typealias Name = ISO_32000.`7`.`3`.`5`.Name

    public typealias Stream = ISO_32000.`7`.`3`.`8`.Stream

    public typealias IndirectReference = ISO_32000.`7`.`3`.`10`.IndirectReference
}

extension ISO_32000.`7`.`3`.COS {

    public struct Dictionary: Sendable, Hashable {
        public var storage: [Name: Object]

        public init() {
            self.storage = [:]
        }

        public init(_ storage: [Name: Object]) {
            self.storage = storage
        }
    }
}

extension ISO_32000.`7`.`3`.COS.Dictionary {
    public subscript(key: ISO_32000.`7`.`3`.COS.Name) -> ISO_32000.`7`.`3`.COS.Object? {
        get { storage[key] }
        set { storage[key] = newValue }
    }

    public var keys: Swift.Dictionary<ISO_32000.`7`.`3`.COS.Name, ISO_32000.`7`.`3`.COS.Object>.Keys
    {
        storage.keys
    }

    public var values:
        Swift.Dictionary<ISO_32000.`7`.`3`.COS.Name, ISO_32000.`7`.`3`.COS.Object>.Values
    {
        storage.values
    }

    public var count: Int {
        storage.count
    }

    public var isEmpty: Bool {
        storage.isEmpty
    }

    public var sortedEntries:
        [(key: ISO_32000.`7`.`3`.COS.Name, value: ISO_32000.`7`.`3`.COS.Object)]
    {
        storage.sorted { $0.key.rawValue < $1.key.rawValue }
    }
}

extension ISO_32000.`7`.`3`.COS.Dictionary: ExpressibleByDictionaryLiteral {
    public init(
        dictionaryLiteral elements: (ISO_32000.`7`.`3`.COS.Name, ISO_32000.`7`.`3`.COS.Object)...
    ) {
        self.storage = .init(uniqueKeysWithValues: elements)
    }
}

extension ISO_32000.`7`.`3`.COS {

    public enum Object: Sendable, Hashable {

        case null

        case boolean(Bool)

        case integer(Int64)

        case real(Double)

        case name(Name)

        case string(StringValue)

        case array([Object])

        case dictionary(Dictionary)

        case stream(Stream)

        case reference(IndirectReference)
    }
}

extension ISO_32000.`7`.`3`.COS.Object {

    public static func integer(_ value: Int) -> Self {
        .integer(Int64(value))
    }

    public static func name(_ value: String) -> Self? {
        let name: ISO_32000.`7`.`3`.COS.Name
        do throws(ISO_32000.`7`.`3`.COS.Name.Error) {
            name = try ISO_32000.`7`.`3`.COS.Name(value)
        } catch {
            return nil
        }
        return .name(name)
    }

    public static func string(_ value: String) -> Self {
        .string(ISO_32000.`7`.`3`.COS.StringValue(value))
    }
}

extension ISO_32000.`7`.`3`.COS.Object: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .boolean(value)
    }
}

extension ISO_32000.`7`.`3`.COS.Object: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self = .integer(value)
    }
}

extension ISO_32000.`7`.`3`.COS.Object: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .real(value)
    }
}

extension ISO_32000.`7`.`3`.COS.Object: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: ISO_32000.`7`.`3`.COS.Object...) {
        self = .array(elements)
    }
}

extension ISO_32000.`7`.`3`.COS {

    public struct StringValue: Sendable, Hashable, Codable {

        public let value: String

        public init(_ value: String) {
            self.value = value
        }
    }
}

extension ISO_32000.`7`.`3`.COS.StringValue: CustomStringConvertible {
    public var description: String {
        "(\(value))"
    }
}

extension ISO_32000.`7`.`3`.COS.StringValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.value = value
    }
}

extension ISO_32000.`7`.`3`.COS {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ object: Object,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        switch object {
        case .null:
            buffer.append(contentsOf: "null".utf8)

        case .boolean(true):
            buffer.append(contentsOf: "true".utf8)

        case .boolean(false):
            buffer.append(contentsOf: "false".utf8)

        case .integer(let value):
            buffer.append(contentsOf: Swift.String(value).utf8)

        case .real(let value):

            ISO_32000.`7`.`3`.`3`.PDFNumber.serializeReal(value, into: &buffer)

        case .name(let name):
            Name.serialize(name, into: &buffer)

        case .string(let str):
            StringValue.serialize(str, into: &buffer)

        case .array(let elements):
            buffer.append(.ascii.leftBracket)
            for (i, element) in elements.enumerated() {
                if i > 0 {
                    buffer.append(.ascii.space)
                }
                serialize(element, into: &buffer)
            }
            buffer.append(.ascii.rightBracket)

        case .dictionary(let dict):
            Dictionary.serialize(dict, into: &buffer)

        case .stream(let stream):
            Stream.serialize(stream, into: &buffer)

        case .reference(let ref):
            buffer.append(contentsOf: "\(ref.objectNumber) \(ref.generation) R".utf8)
        }
    }
}

extension ISO_32000.`7`.`3`.COS.Object: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ object: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        ISO_32000.`7`.`3`.COS.serialize(object, into: &buffer)
    }
}

extension ISO_32000.`7`.`3`.COS.Dictionary: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ dict: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(.ascii.lessThan)
        buffer.append(.ascii.lessThan)

        for (key, value) in dict.sortedEntries {
            buffer.append(.ascii.space)
            ISO_32000.`7`.`3`.COS.Name.serialize(key, into: &buffer)
            buffer.append(.ascii.space)
            ISO_32000.`7`.`3`.COS.Object.serialize(value, into: &buffer)
        }

        buffer.append(.ascii.greaterThan)
        buffer.append(.ascii.greaterThan)
    }
}

extension ISO_32000.`7`.`3`.`5`.Name: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ name: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(.ascii.solidus)

        for byte in [Byte](name.rawValue.utf8) {
            let raw = byte.underlying
            if shouldEscapeNameByte(raw) {
                buffer.append(.ascii.numberSign)
                buffer.append(hexChar(raw >> 4))
                buffer.append(hexChar(raw & 0x0F))
            } else {
                buffer.append(byte)
            }
        }
    }

    private static func shouldEscapeNameByte(_ byte: UInt8) -> Bool {
        if !byte.ascii.isVisible { return true }
        if byte == .ascii.numberSign { return true }
        if byte == .ascii.leftParenthesis || byte == .ascii.rightParenthesis { return true }
        if byte == .ascii.lessThan || byte == .ascii.greaterThan { return true }
        if byte == .ascii.leftBracket || byte == .ascii.rightBracket { return true }
        if byte == .ascii.leftBrace || byte == .ascii.rightBrace { return true }
        if byte == .ascii.solidus { return true }
        if byte == .ascii.percentSign { return true }
        return false
    }

    private static func hexChar(_ nibble: UInt8) -> ASCII.Code {
        ASCII.Hexadecimal.code(nibble, case: .upper) ?? 0x30
    }
}

extension ISO_32000.`7`.`3`.COS.StringValue: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ str: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(.ascii.leftParenthesis)
        let useDocEnc = str.value.unicodeScalars.allSatisfy {
            ISO_32000.PDFDocEncoding.canEncode($0)
        }
        if useDocEnc {
            for scalar in str.value.unicodeScalars {
                guard let byte = ISO_32000.PDFDocEncoding.encode(scalar) else { continue }
                if let escaped = ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] {
                    buffer.append(contentsOf: escaped)
                } else {
                    buffer.append(byte)
                }
            }
        } else {
            buffer.append(0xFE)
            buffer.append(0xFF)
            for codeUnit in str.value.utf16 {

                for byte in codeUnit.bytes(endianness: .big) {
                    if let escaped = ISO_32000.`7`.`3`.Table.`3`.escapeTable[byte] {
                        buffer.append(contentsOf: escaped)
                    } else {
                        buffer.append(byte)
                    }
                }
            }
        }
        buffer.append(.ascii.rightParenthesis)
    }
}

extension ISO_32000.`7`.`3`.`8`.Stream: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ stream: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        var dict = stream.dictionary
        dict[.length] = .integer(Int64(stream.data.count))
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)

        buffer.append(contentsOf: "\nstream\n".utf8)
        buffer.append(contentsOf: stream.data)
        buffer.append(contentsOf: "\nendstream".utf8)
    }
}

extension ISO_32000.`7`.`3`.`10`.IndirectReference: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ ref: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: "\(ref.objectNumber) \(ref.generation) R".utf8)
    }
}

extension Double {

    public var pdf: ISO_32000.`7`.`3`.`3`.PDFNumber {
        ISO_32000.`7`.`3`.`3`.PDFNumber(value: self)
    }
}

extension ISO_32000.`7`.`3`.`3` {

    public struct PDFNumber: Sendable, Binary.Serializable {
        public let value: Double
    }
}

extension ISO_32000.`7`.`3`.`3`.PDFNumber {
    public static func serialize<Buffer>(
        _ number: ISO_32000_Shared.ISO_32000.`7`.`3`.`3`.PDFNumber,
        into buffer: inout Buffer
    ) where Buffer: RangeReplaceableCollection, Buffer.Element == Byte {
        serializeReal(number.value, into: &buffer)
    }

    private static let maxDecimalPlaces = 5

    private static let multiplier: Double = 100_000

    static func serializeReal<Buffer: RangeReplaceableCollection>(
        _ value: Double,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {

        guard IEEE_754.Classification.isFinite(value) else {
            buffer.append(.ascii.0)
            return
        }

        let magnitude = value.magnitude
        let isNegative = value.sign == .minus

        let intPart: UInt64 = magnitude >= 0x1p64 ? UInt64.max : UInt64(magnitude)

        var fracDigits: UInt64 = 0
        if magnitude < 0x1p53 {
            let fracPart = magnitude - Double(intPart)
            fracDigits = UInt64((fracPart * Self.multiplier).rounded())
        }

        var carriedIntPart = intPart
        if fracDigits >= UInt64(Self.multiplier) {
            fracDigits = 0
            if carriedIntPart < UInt64.max { carriedIntPart += 1 }
        }

        if isNegative && !(carriedIntPart == 0 && fracDigits == 0) {
            buffer.append(.ascii.hyphen)
        }
        ASCII.Decimal.serialize(carriedIntPart, into: &buffer)

        if fracDigits != 0 {
            buffer.append(.ascii.period)

            var fracValue = fracDigits
            let zero = ASCII.Code.`0`

            func digit(_ value: UInt64) -> ASCII.Code {

                ASCII.Decimal.code(UInt8(value % 10)) ?? 0x30
            }

            var digits = InlineArray<5, ASCII.Code>(repeating: zero)
            digits[4] = digit(fracValue)
            fracValue /= 10
            digits[3] = digit(fracValue)
            fracValue /= 10
            digits[2] = digit(fracValue)
            fracValue /= 10
            digits[1] = digit(fracValue)
            fracValue /= 10
            digits[0] = digit(fracValue)

            var count = 5
            while count > 1 && digits[count - 1] == zero {
                count -= 1
            }

            for i in 0..<count {
                buffer.append(digits[i])
            }
        }
    }
}
