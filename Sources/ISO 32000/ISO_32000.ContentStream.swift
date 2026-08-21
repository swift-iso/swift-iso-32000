public import Binary_Primitives
public import Binary_Serializable_Primitives
import Byte_Primitives
public import Geometry_Primitives
import ISO_9899
import Standard_Library_Extensions

extension ISO_32000 {

    public struct ContentStream: Sendable {

        public var data: [Byte]

        public var fontsUsed: Set<Font>

        public var imagesUsed: Set<Image>

        public init() {
            self.data = []
            self.fontsUsed = []
            self.imagesUsed = []
        }

        public init(
            data: [Byte],
            fontsUsed: Set<Font> = [],
            imagesUsed: Set<Image> = []
        ) {
            self.data = data
            self.fontsUsed = fontsUsed
            self.imagesUsed = imagesUsed
        }

        public init(_ build: (inout Builder) -> Void) {
            var builder = Builder()
            build(&builder)
            self.data = builder.data
            self.fontsUsed = builder.fontsUsed
            self.imagesUsed = builder.imagesUsed
        }
    }
}

extension ISO_32000.ContentStream {

    public struct Builder: Sendable {

        public var data: [Byte] = []

        public var fontsUsed: Set<ISO_32000.Font> = []

        public var imagesUsed: Set<ISO_32000.Image> = []

        public init() {}
    }
}

extension ISO_32000.ContentStream.Builder {

    private mutating func emit(_ op: ISO_32000.ContentStream.Operator) {
        if !data.isEmpty {
            data.append(.ascii.lf)
        }
        op.serialize(into: &data)
    }

    public mutating func saveGraphicsState() {
        emit(.saveState)
    }

    public mutating func restoreGraphicsState() {
        emit(.restoreState)
    }

    public mutating func transform(
        a: Scale<1, Double>,
        b: Scale<1, Double>,
        c: Scale<1, Double>,
        d: Scale<1, Double>,
        e: ISO_32000.UserSpace.Dx,
        f: ISO_32000.UserSpace.Dy
    ) {
        emit(.transform(a: a, b: b, c: c, d: d, e: e, f: f))
    }

    public mutating func translate(dx: ISO_32000.UserSpace.Dx, dy: ISO_32000.UserSpace.Dy) {
        emit(.transform(a: 1, b: 0, c: 0, d: 1, e: dx, f: dy))
    }

    public mutating func scale(x: Scale<1, Double>, y: Scale<1, Double>) {
        emit(.transform(a: x, b: 0, c: 0, d: y, e: .init(0), f: .init(0)))
    }

    public mutating func setStrokeColorGray(_ gray: Double) {
        emit(.setStrokeGray(gray))
    }

    public mutating func setFillColorGray(_ gray: Double) {
        emit(.setFillGray(gray))
    }

    public mutating func setStrokeColorRGB(r: Double, g: Double, b: Double) {
        emit(.setStrokeRGB(r: r, g: g, b: b))
    }

    public mutating func setFillColorRGB(r: Double, g: Double, b: Double) {
        emit(.setFillRGB(r: r, g: g, b: b))
    }

    public mutating func setStrokeColorCMYK(c: Double, m: Double, y: Double, k: Double) {
        emit(.setStrokeCMYK(c: c, m: m, y: y, k: k))
    }

    public mutating func setFillColorCMYK(c: Double, m: Double, y: Double, k: Double) {
        emit(.setFillCMYK(c: c, m: m, y: y, k: k))
    }

    public mutating func moveTo(x: ISO_32000.UserSpace.X, y: ISO_32000.UserSpace.Y) {
        emit(.moveTo(x: x, y: y))
    }

    public mutating func lineTo(x: ISO_32000.UserSpace.X, y: ISO_32000.UserSpace.Y) {
        emit(.lineTo(x: x, y: y))
    }

    public mutating func curveTo(
        x1: ISO_32000.UserSpace.X,
        y1: ISO_32000.UserSpace.Y,
        x2: ISO_32000.UserSpace.X,
        y2: ISO_32000.UserSpace.Y,
        x3: ISO_32000.UserSpace.X,
        y3: ISO_32000.UserSpace.Y
    ) {
        emit(.curveTo(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3))
    }

    public mutating func rectangle(
        x: ISO_32000.UserSpace.X,
        y: ISO_32000.UserSpace.Y,
        width: ISO_32000.UserSpace.Width,
        height: ISO_32000.UserSpace.Height
    ) {
        emit(.rectangle(x: x, y: y, width: width, height: height))
    }

    public mutating func closePath() {
        emit(.closePath)
    }

    public mutating func stroke() {
        emit(.stroke)
    }

    public mutating func closeAndStroke() {
        emit(.closeAndStroke)
    }

    public mutating func fill() {
        emit(.fill)
    }

    public mutating func fillEvenOdd() {
        emit(.fillEvenOdd)
    }

    public mutating func fillAndStroke() {
        emit(.fillAndStroke)
    }

    public mutating func endPath() {
        emit(.endPath)
    }

    public mutating func clip() {
        emit(.clip)
    }

    public mutating func clipEvenOdd() {
        emit(.clipEvenOdd)
    }

    public mutating func beginText() {
        emit(.beginText)
    }

    public mutating func endText() {
        emit(.endText)
    }

    public mutating func setFont(_ font: ISO_32000.Font, size: ISO_32000.UserSpace.Size<1>) {
        fontsUsed.insert(font)
        emit(.setFont(name: font.resourceName, size: size))
    }

    public mutating func moveText(
        dx: ISO_32000.UserSpace.Dx,
        dy: ISO_32000.UserSpace.Dy
    ) {
        emit(.moveTextPosition(tx: dx, ty: dy))
    }

    public mutating func moveTextWithLeading(
        dx: ISO_32000.UserSpace.Dx,
        dy: ISO_32000.UserSpace.Dy
    ) {
        emit(.moveTextPositionWithLeading(tx: dx, ty: dy))
    }

    public mutating func setTextMatrix(
        a: Scale<1, Double>,
        b: Scale<1, Double>,
        c: Scale<1, Double>,
        d: Scale<1, Double>,
        e: ISO_32000.UserSpace.Dx,
        f: ISO_32000.UserSpace.Dy
    ) {
        emit(.setTextMatrix(a: a, b: b, c: c, d: d, e: e, f: f))
    }

    public mutating func nextLine() {
        emit(.nextLine)
    }

    public mutating func showText(_ bytes: [Byte]) {
        emit(.showText(bytes))
    }

    public mutating func showText(_ text: String) {

        let bytes = [Byte](winAnsi: text, withFallback: true)
        emit(.showText(bytes))
    }

    public mutating func setTextLeading(_ leading: ISO_32000.UserSpace.Height) {
        emit(.setTextLeading(leading))
    }

    public mutating func setCharacterSpacing(_ spacing: ISO_32000.UserSpace.Width) {
        emit(.setCharacterSpacing(spacing))
    }

    public mutating func setWordSpacing(_ spacing: ISO_32000.UserSpace.Width) {
        emit(.setWordSpacing(spacing))
    }

    public mutating func setHorizontalScaling(_ scale: Scale<1, Double>) {
        emit(.setHorizontalScaling(scale))
    }

    public mutating func setTextRise(_ rise: ISO_32000.UserSpace.Y) {
        emit(.setTextRise(rise))
    }

    public mutating func setLineWidth(_ width: ISO_32000.UserSpace.Width) {
        emit(.setLineWidth(width))
    }

    public mutating func setLineCap(_ cap: ISO_32000.ContentStream.LineCap) {
        emit(.setLineCap(cap))
    }

    public mutating func setLineJoin(_ join: ISO_32000.ContentStream.LineJoin) {
        emit(.setLineJoin(join))
    }

    public mutating func setMiterLimit(_ limit: ISO_32000.UserSpace.Width) {
        emit(.setMiterLimit(limit))
    }

    public mutating func setDashPattern(
        array: [ISO_32000.UserSpace.Width],
        phase: ISO_32000.UserSpace.Width
    ) {
        emit(.setDashPattern(array: array, phase: phase))
    }

    public mutating func beginMarkedContent(tag: ISO_32000.COS.Name) {
        emit(.beginMarkedContent(tag: tag))
    }

    public mutating func beginMarkedContent(
        tag: ISO_32000.COS.Name,
        properties: ISO_32000.COS.Dictionary
    ) {
        emit(.beginMarkedContentWithProperties(tag: tag, properties: properties))
    }

    public mutating func endMarkedContent() {
        emit(.endMarkedContent)
    }

    public mutating func beginActualTextSpan(_ actualText: String) {
        let properties: ISO_32000.COS.Dictionary = [
            .actualText: .string(actualText)
        ]
        emit(.beginMarkedContentWithProperties(tag: .span, properties: properties))
    }

    public mutating func endActualTextSpan() {
        emit(.endMarkedContent)
    }

    public mutating func paintXObject(name: ISO_32000.COS.Name) {
        emit(.paintXObject(name: name))
    }

    public mutating func drawImage(
        _ image: ISO_32000.Image,
        in rect: ISO_32000.UserSpace.Rectangle
    ) {
        imagesUsed.insert(image)
        emit(.saveState)

        let dx = rect.origin.x - ISO_32000.UserSpace.X.zero
        let dy = rect.origin.y - ISO_32000.UserSpace.Y.zero

        let scaleX = rect.width / ISO_32000.UserSpace.Width(1)
        let scaleY = rect.height / ISO_32000.UserSpace.Height(1)

        emit(.transform(a: scaleX, b: 0, c: 0, d: scaleY, e: dx, f: dy))
        emit(.paintXObject(name: image.resourceName))
        emit(.restoreState)
    }

    public mutating func transform(_ t: ISO_32000.UserSpace.Transform) {
        emit(
            .transform(
                a: t.a,
                b: t.b,
                c: t.c,
                d: t.d,
                e: t.tx,
                f: t.ty
            )
        )
    }

    public mutating func rotate(_ angle: Radian<Double>) {
        emit(
            .transform(
                a: angle.cos,
                b: angle.sin,
                c: -angle.sin,
                d: angle.cos,
                e: .init(0),
                f: .init(0)
            )
        )
    }

    public mutating func rotate(_ angle: Degree<Double>) {
        rotate(angle.radians)
    }

    public mutating func translate(_ vector: ISO_32000.UserSpace.Vector<2>) {
        emit(.transform(a: 1, b: 0, c: 0, d: 1, e: vector.dx, f: vector.dy))
    }

    public mutating func moveTo(_ point: ISO_32000.UserSpace.Coordinate) {
        emit(.moveTo(x: point.x, y: point.y))
    }

    public mutating func lineTo(_ point: ISO_32000.UserSpace.Coordinate) {
        emit(.lineTo(x: point.x, y: point.y))
    }

    public mutating func curveTo(
        control1: ISO_32000.UserSpace.Coordinate,
        control2: ISO_32000.UserSpace.Coordinate,
        end: ISO_32000.UserSpace.Coordinate
    ) {
        emit(
            .curveTo(
                x1: control1.x,
                y1: control1.y,
                x2: control2.x,
                y2: control2.y,
                x3: end.x,
                y3: end.y
            )
        )
    }

    public mutating func rectangle(_ rect: ISO_32000.UserSpace.Rectangle) {
        emit(
            .rectangle(
                x: rect.origin.x,
                y: rect.origin.y,
                width: rect.width,
                height: rect.height
            )
        )
    }

    public mutating func circle(_ circle: ISO_32000.UserSpace.Circle) {
        let start = circle.bezierStartPoint
        emit(.moveTo(x: start.x, y: start.y))

        for segment in circle.bezierCurves {
            emit(
                .curveTo(
                    x1: segment.control1.x,
                    y1: segment.control1.y,
                    x2: segment.control2.x,
                    y2: segment.control2.y,
                    x3: segment.end.x,
                    y3: segment.end.y
                )
            )
        }

        emit(.closePath)
    }

    public mutating func moveText(_ displacement: ISO_32000.UserSpace.Vector<2>) {
        emit(.moveTextPosition(tx: displacement.dx, ty: displacement.dy))
    }

    public mutating func setTextMatrix(_ t: ISO_32000.UserSpace.Transform) {
        emit(
            .setTextMatrix(
                a: t.a,
                b: t.b,
                c: t.c,
                d: t.d,
                e: t.tx,
                f: t.ty
            )
        )
    }
}

extension ISO_32000.ContentStream {

    public enum LineCap: Int, Sendable {
        case butt = 0
        case round = 1
        case square = 2
    }

    public enum LineJoin: Int, Sendable {
        case miter = 0
        case round = 1
        case bevel = 2
    }
}

extension ISO_32000.ContentStream: Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ stream: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: stream.data)
    }
}
