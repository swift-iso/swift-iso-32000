public import Byte
public import ISO_32000
public import RFC_1950
import W3C_PNG

extension ISO_32000.Image {

    public init(
        png pngData: [Byte],
        compressionLevel: RFC_1951.Level = .balanced
    ) throws(Parse.Error) {

        let image: W3C_PNG::W3C_PNG.Image
        do throws(W3C_PNG::W3C_PNG.ParseError) {
            image = try W3C_PNG::W3C_PNG.parse(pngData)
        } catch {
            throw .invalidHeader
        }

        let (rawPixels, colorSpace, alpha) = Self.convertToRawPixels(image)

        var compressedData: [Byte] = []
        RFC_1950.compress(rawPixels, into: &compressedData, level: compressionLevel)

        self.init(
            pixelWidth: image.width,
            pixelHeight: image.height,
            colorSpace: colorSpace,
            bitsPerComponent: 8,
            filter: .flateDecode,
            data: compressedData,
            softMask: alpha.map { RFC_1950.compress($0, level: compressionLevel) }
        )
    }

    private static func convertToRawPixels(
        _ image: W3C_PNG::W3C_PNG.Image
    ) -> (pixels: [Byte], colorSpace: Color.Space, alpha: [Byte]?) {
        switch image.colorType {
        case .grayscale:

            return (image.rawPixels, .deviceGray, nil)

        case .rgb:

            return (image.rawPixels, .deviceRGB, nil)

        case .rgba:

            var rgb: [Byte] = []
            var alpha: [Byte] = []
            rgb.reserveCapacity(image.width * image.height * 3)
            alpha.reserveCapacity(image.width * image.height)
            for i in stride(from: 0, to: image.rawPixels.count, by: 4) {
                rgb.append(image.rawPixels[i])
                rgb.append(image.rawPixels[i + 1])
                rgb.append(image.rawPixels[i + 2])
                alpha.append(image.rawPixels[i + 3])
            }
            return (rgb, .deviceRGB, alpha)

        case .grayscaleAlpha:

            var gray: [Byte] = []
            var alpha: [Byte] = []
            gray.reserveCapacity(image.width * image.height)
            alpha.reserveCapacity(image.width * image.height)
            for i in stride(from: 0, to: image.rawPixels.count, by: 2) {
                gray.append(image.rawPixels[i])
                alpha.append(image.rawPixels[i + 1])
            }
            return (gray, .deviceGray, alpha)

        case .indexed:

            guard let palette = image.palette else {

                return (image.rawPixels, .deviceGray, nil)
            }
            var rgb: [Byte] = []
            rgb.reserveCapacity(image.width * image.height * 3)
            for index in image.rawPixels {
                let idx = Int(UInt8(bitPattern: index))
                if idx < palette.count {
                    let entry = palette[idx]
                    rgb.append(entry.r)
                    rgb.append(entry.g)
                    rgb.append(entry.b)
                } else {

                    rgb.append(Byte(bitPattern: 0))
                    rgb.append(Byte(bitPattern: 0))
                    rgb.append(Byte(bitPattern: 0))
                }
            }
            return (rgb, .deviceRGB, nil)
        }
    }
}
