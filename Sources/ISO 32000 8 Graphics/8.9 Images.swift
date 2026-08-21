internal import Binary_Endianness_Primitives
internal import Binary_Primitives_Standard_Library_Integration
public import Byte_Primitives
internal import Byte_Primitives_Standard_Library_Integration
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Synchronization

extension ISO_32000.`8` {

    public enum `9` {}
}

extension ISO_32000.`8`.`9` {

    public struct Image: Sendable, Hashable {

        public let pixelWidth: Int

        public let pixelHeight: Int

        public let colorSpace: Color.Space

        public let bitsPerComponent: Int

        public let filter: Filter

        public let data: [Byte]

        public let id: UInt64

        public init(
            pixelWidth: Int,
            pixelHeight: Int,
            colorSpace: Color.Space,
            bitsPerComponent: Int,
            filter: Filter,
            data: [Byte]
        ) {
            self.pixelWidth = pixelWidth
            self.pixelHeight = pixelHeight
            self.colorSpace = colorSpace
            self.bitsPerComponent = bitsPerComponent
            self.filter = filter
            self.data = data
            self.id = Self.nextID()
        }
    }
}

extension ISO_32000.`8`.`9`.Image {

    private static let idCounter = Atomic<UInt64>(0)

    private static func nextID() -> UInt64 {
        idCounter.wrappingAdd(1, ordering: .relaxed).newValue
    }
}

extension ISO_32000.`8`.`9`.Image {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ISO_32000.`8`.`9`.Image {

    public enum Color {}
}

extension ISO_32000.`8`.`9`.Image.Color {

    public enum Space: Sendable, Hashable {

        case deviceGray

        case deviceRGB

        case deviceCMYK
    }
}

extension ISO_32000.`8`.`9`.Image.Color.Space {

    public var components: Int {
        switch self {
        case .deviceGray: 1
        case .deviceRGB: 3
        case .deviceCMYK: 4
        }
    }
}

extension ISO_32000.`8`.`9`.Image {

    public enum Filter: Sendable, Hashable {

        case dctDecode

        case flateDecode
    }
}

extension ISO_32000.`8`.`9`.Image {

    public enum Parse {}
}

extension ISO_32000.`8`.`9`.Image.Parse {

    public enum Error: Swift.Error, Sendable, Hashable {

        case invalidHeader

        case unsupportedColorSpace(components: Int)

        case truncatedData

        case missingMarker

        case unsupportedFormat
    }
}

extension ISO_32000.`8`.`9`.Image {

    public init(jpeg jpegData: [Byte]) throws(Parse.Error) {

        guard jpegData.count >= 2,
            jpegData[0] == 0xFF,
            jpegData[1] == 0xD8
        else {
            throw .invalidHeader
        }

        let (width, height, components) = try Self.parseJPEGHeader(jpegData)

        self.pixelWidth = width
        self.pixelHeight = height
        self.bitsPerComponent = 8
        self.filter = .dctDecode
        self.data = jpegData
        self.id = Self.nextID()

        switch components {
        case 1:
            self.colorSpace = .deviceGray

        case 3:
            self.colorSpace = .deviceRGB

        case 4:
            self.colorSpace = .deviceCMYK

        default:
            throw .unsupportedColorSpace(components: components)
        }
    }

    private static func parseJPEGHeader(
        _ data: [Byte]
    ) throws(Parse.Error) -> (width: Int, height: Int, components: Int) {
        var offset = 2

        while offset < data.count - 1 {
            guard data[offset] == 0xFF else {
                offset += 1
                continue
            }

            let marker = data[offset + 1]
            offset += 2

            guard marker != 0xFF && marker != 0x00 else { continue }

            if marker == 0xC0 || marker == 0xC2 {
                guard offset + 7 < data.count else {
                    throw .truncatedData
                }

                let height = Int(UInt16(bytes: data[offset + 3..<offset + 5], endianness: .big)!)

                let width = Int(UInt16(bytes: data[offset + 5..<offset + 7], endianness: .big)!)

                let components = Int(data[offset + 7])

                return (width, height, components)
            }

            if marker >= 0xD0 && marker <= 0xD9 || marker == 0x01 {
                continue
            }

            guard offset + 1 < data.count else {
                throw .truncatedData
            }
            let length = Int(UInt16(bytes: data[offset..<offset + 2], endianness: .big)!)
            offset += length
        }

        throw .missingMarker
    }
}

extension ISO_32000.`8`.`9`.Image {

    public var resourceName: ISO_32000.`7`.`3`.COS.Name {

        try! .init("Im\(id)")
    }
}
