public import ISO_32000_12_Interactive_features
import ISO_32000_8_Graphics

extension ISO_32000 {

    public struct Page: Sendable {

        public var mediaBox: ISO_32000.UserSpace.Rectangle

        public var cropBox: ISO_32000.UserSpace.Rectangle?

        public var bleedBox: ISO_32000.UserSpace.Rectangle?

        public var trimBox: ISO_32000.UserSpace.Rectangle?

        public var artBox: ISO_32000.UserSpace.Rectangle?

        public var rotation: Degree<Double>?

        public var contents: [ISO_32000.ContentStream]

        public var resources: ISO_32000.Resources

        public var annotations: [ISO_32000.Annotation]

        public init(
            mediaBox: ISO_32000.UserSpace.Rectangle = .a4,
            cropBox: ISO_32000.UserSpace.Rectangle? = nil,
            bleedBox: ISO_32000.UserSpace.Rectangle? = nil,
            trimBox: ISO_32000.UserSpace.Rectangle? = nil,
            artBox: ISO_32000.UserSpace.Rectangle? = nil,
            rotation: Degree<Double>? = nil,
            contents: [ISO_32000.ContentStream] = [],
            resources: ISO_32000.Resources = ISO_32000.Resources(),
            annotations: [ISO_32000.Annotation] = []
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
            mediaBox: ISO_32000.UserSpace.Rectangle = .a4,
            content: ISO_32000.ContentStream,
            resources: ISO_32000.Resources = ISO_32000.Resources(),
            annotations: [ISO_32000.Annotation] = []
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

extension ISO_32000.Page {

    public typealias Boundary = ISO_32000.`12`.`2`.Boundary

    public typealias Range = ISO_32000.`12`.`2`.PageRange

    public static func empty(size: ISO_32000.UserSpace.Rectangle = .a4) -> Self {
        Self(mediaBox: size)
    }
}

extension ISO_32000.Page {

    public var width: ISO_32000.UserSpace.Width { mediaBox.width }

    public var height: ISO_32000.UserSpace.Height { mediaBox.height }

    public var effectiveCropBox: ISO_32000.UserSpace.Rectangle {
        cropBox ?? mediaBox
    }

    public var effectiveBleedBox: ISO_32000.UserSpace.Rectangle {
        bleedBox ?? effectiveCropBox
    }

    public var effectiveTrimBox: ISO_32000.UserSpace.Rectangle {
        trimBox ?? effectiveCropBox
    }

    public var effectiveArtBox: ISO_32000.UserSpace.Rectangle {
        artBox ?? effectiveCropBox
    }
}

extension ISO_32000 {

    public struct Resources: Sendable {

        public var fonts: [COS.Name: Font]

        public var xObjects: [COS.Name: Image]

        public init() {
            self.fonts = [:]
            self.xObjects = [:]
        }

        public init(fonts: [COS.Name: Font], xObjects: [COS.Name: Image] = [:]) {
            self.fonts = fonts
            self.xObjects = xObjects
        }
    }
}

extension ISO_32000.Resources {

    @discardableResult
    public mutating func addFont(_ font: ISO_32000.Font) -> ISO_32000.COS.Name {
        let name = font.resourceName
        fonts[name] = font
        return name
    }

    @discardableResult
    public mutating func addImage(_ image: ISO_32000.Image) -> ISO_32000.COS.Name {
        let name = image.resourceName
        xObjects[name] = image
        return name
    }
}
