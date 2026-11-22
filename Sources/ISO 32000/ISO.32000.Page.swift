public import ISO_32000_12_Interactive_features
import ISO_32000_8_Graphics

extension ISO.`32000` {

    public struct Page: Sendable {

        public var mediaBox: ISO.`32000`.UserSpace.Rectangle

        public var cropBox: ISO.`32000`.UserSpace.Rectangle?

        public var bleedBox: ISO.`32000`.UserSpace.Rectangle?

        public var trimBox: ISO.`32000`.UserSpace.Rectangle?

        public var artBox: ISO.`32000`.UserSpace.Rectangle?

        public var rotation: Degree<Double>?

        public var contents: [ISO.`32000`.ContentStream]

        public var resources: ISO.`32000`.Resources

        public var annotations: [ISO.`32000`.Annotation]

        public init(
            mediaBox: ISO.`32000`.UserSpace.Rectangle = .a4,
            cropBox: ISO.`32000`.UserSpace.Rectangle? = nil,
            bleedBox: ISO.`32000`.UserSpace.Rectangle? = nil,
            trimBox: ISO.`32000`.UserSpace.Rectangle? = nil,
            artBox: ISO.`32000`.UserSpace.Rectangle? = nil,
            rotation: Degree<Double>? = nil,
            contents: [ISO.`32000`.ContentStream] = [],
            resources: ISO.`32000`.Resources = ISO.`32000`.Resources(),
            annotations: [ISO.`32000`.Annotation] = []
        ) {
            self.mediaBox = mediaBox
            self.cropBox = cropBox
            self.bleedBox = bleedBox
            self.trimBox = trimBox
            self.artBox = artBox
            self.rotation = rotation
            self.contents = contents
            self.resources = resources
            self.annotations = annotations
        }

        public init(
            mediaBox: ISO.`32000`.UserSpace.Rectangle = .a4,
            content: ISO.`32000`.ContentStream,
            resources: ISO.`32000`.Resources = ISO.`32000`.Resources(),
            annotations: [ISO.`32000`.Annotation] = []
        ) {
            self.mediaBox = mediaBox
            self.cropBox = nil
            self.bleedBox = nil
            self.trimBox = nil
            self.artBox = nil
            self.rotation = nil
            self.contents = [content]
            self.resources = resources
            self.annotations = annotations
        }

    }
}

extension ISO.`32000`.Page {

    public typealias Boundary = ISO.`32000`.`12`.`2`.Boundary

    public typealias Range = ISO.`32000`.`12`.`2`.PageRange

    public static func empty(size: ISO.`32000`.UserSpace.Rectangle = .a4) -> Self {
        Self(mediaBox: size)
    }
}

extension ISO.`32000`.Page {

    public var width: ISO.`32000`.UserSpace.Width { mediaBox.width }

    public var height: ISO.`32000`.UserSpace.Height { mediaBox.height }

    public var effectiveCropBox: ISO.`32000`.UserSpace.Rectangle {
        cropBox ?? mediaBox
    }

    public var effectiveBleedBox: ISO.`32000`.UserSpace.Rectangle {
        bleedBox ?? effectiveCropBox
    }

    public var effectiveTrimBox: ISO.`32000`.UserSpace.Rectangle {
        trimBox ?? effectiveCropBox
    }

    public var effectiveArtBox: ISO.`32000`.UserSpace.Rectangle {
        artBox ?? effectiveCropBox
    }
}

extension ISO.`32000` {
}

extension ISO.`32000`.Resources {

    @discardableResult
    public mutating func addFont(_ font: ISO.`32000`.Font) -> ISO.`32000`.COS.Name {
        let name = font.resourceName
        fonts[name] = font
        return name
    }

    @discardableResult
    public mutating func addImage(_ image: ISO.`32000`.Image) -> ISO.`32000`.COS.Name {
        let name = image.resourceName
        xObjects[name] = image
        return name
    }
}
