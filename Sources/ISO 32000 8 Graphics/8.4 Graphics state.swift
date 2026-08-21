public import Geometry_Primitives
public import ISO_32000_Shared
import Real_Primitives

extension ISO_32000.`8` {

    public enum `4` {}
}

extension ISO_32000.`8`.`4` {

    public enum Graphics {}
}

extension ISO_32000.`8`.`4`.Graphics {

    public enum State {}
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public enum Line {}
}

extension ISO_32000.`8`.`4`.Graphics.State.Line {

    public enum Cap: Int, Sendable, Codable, Hashable, CaseIterable {

        case butt = 0

        case round = 1

        case projectingSquare = 2
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Line {

    public enum Join: Int, Sendable, Codable, Hashable, CaseIterable {

        case miter = 0

        case round = 1

        case bevel = 2
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Line {

    public enum Dash {}
}

extension ISO_32000.`8`.`4`.Graphics.State.Line.Dash {

    public struct Pattern: Sendable, Codable, Hashable {

        public var array: [Double]

        public var phase: Double

        public init(array: [Double] = [], phase: Double = 0) {
            self.array = array
            self.phase = phase
        }
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Line.Dash.Pattern {

    public static let solid = ISO_32000.`8`.`4`.Graphics.State.Line.Dash.Pattern(
        array: [],
        phase: 0
    )
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public enum Rendering {}
}

extension ISO_32000.`8`.`4`.Graphics.State.Rendering {

    public enum Intent: String, Sendable, Codable, Hashable, CaseIterable {

        case relativeColorimetric = "RelativeColorimetric"

        case absoluteColorimetric = "AbsoluteColorimetric"

        case saturation = "Saturation"

        case perceptual = "Perceptual"
    }
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public struct BlackPoint {
        public var compensation: Compensation

        public init(compensation: Compensation) {
            self.compensation = compensation
        }
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.BlackPoint {

    public enum Compensation: String, Sendable, Codable, Hashable, CaseIterable {

        case off = "OFF"

        case on = "ON"

        case `default` = "Default"
    }
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public struct Blend {
        public var mode: Blend.Mode

        public init(
            mode: Blend.Mode
        ) {
            self.mode = mode
        }
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Blend {

    public enum Mode: String, Sendable, Codable, Hashable, CaseIterable {

        case normal = "Normal"

        case multiply = "Multiply"

        case screen = "Screen"

        case overlay = "Overlay"

        case darken = "Darken"

        case lighten = "Lighten"

        case colorDodge = "ColorDodge"

        case colorBurn = "ColorBurn"

        case hardLight = "HardLight"

        case softLight = "SoftLight"

        case difference = "Difference"

        case exclusion = "Exclusion"

        case hue = "Hue"

        case saturation = "Saturation"

        case color = "Color"

        case luminosity = "Luminosity"
    }
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public enum Device {}
}

extension ISO_32000.`8`.`4`.Graphics.State.Device {

    public struct Combined<TextState: Sendable>: Sendable {
        public var independent: Independent<TextState>
        public var dependent: Dependent
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Device {

    public struct Independent<TextState: Sendable>: Sendable {

        public var ctm: ISO_32000.UserSpace.Transform

        public var strokingColorSpace: ISO_32000.`8`.`4`.Graphics.State.ColorSpace

        public var nonstrokingColorSpace: ISO_32000.`8`.`4`.Graphics.State.ColorSpace

        public var strokingColor: ISO_32000.`8`.`4`.Graphics.State.Color

        public var nonstrokingColor: ISO_32000.`8`.`4`.Graphics.State.Color

        public var textState: TextState

        public var lineWidth: ISO_32000.UserSpace.Width

        public var lineCap: ISO_32000.`8`.`4`.Graphics.State.Line.Cap

        public var lineJoin: ISO_32000.`8`.`4`.Graphics.State.Line.Join

        public var miterLimit: Scale<1, Double>

        public var dashPattern: ISO_32000.`8`.`4`.Graphics.State.Line.Dash.Pattern

        public var renderingIntent: ISO_32000.`8`.`4`.Graphics.State.Rendering.Intent

        public var strokeAdjustment: Bool

        public var blendMode: ISO_32000.`8`.`4`.Graphics.State.Blend.Mode

        public var softMask: ISO_32000.`8`.`4`.Graphics.State.SoftMask?

        public var strokingAlphaConstant: Opacity<Double>

        public var nonstrokingAlphaConstant: Opacity<Double>

        public var alphaSource: Bool

        public var blackPointCompensation: ISO_32000.`8`.`4`.Graphics.State.BlackPoint.Compensation

        public init(
            ctm: ISO_32000.UserSpace.Transform = .identity,
            strokingColorSpace: ISO_32000.`8`.`4`.Graphics.State.ColorSpace = .deviceGray,
            nonstrokingColorSpace: ISO_32000.`8`.`4`.Graphics.State.ColorSpace = .deviceGray,
            strokingColor: ISO_32000.`8`.`4`.Graphics.State.Color = .gray(0),
            nonstrokingColor: ISO_32000.`8`.`4`.Graphics.State.Color = .gray(0),
            textState: TextState,
            lineWidth: ISO_32000.UserSpace.Width = .init(1),
            lineCap: ISO_32000.`8`.`4`.Graphics.State.Line.Cap = .butt,
            lineJoin: ISO_32000.`8`.`4`.Graphics.State.Line.Join = .miter,
            miterLimit: Scale<1, Double> = .init(10),
            dashPattern: ISO_32000.`8`.`4`.Graphics.State.Line.Dash.Pattern = .solid,
            renderingIntent: ISO_32000.`8`.`4`.Graphics.State.Rendering.Intent =
                .relativeColorimetric,
            strokeAdjustment: Bool = false,
            blendMode: ISO_32000.`8`.`4`.Graphics.State.Blend.Mode = .normal,
            softMask: ISO_32000.`8`.`4`.Graphics.State.SoftMask? = nil,
            strokingAlphaConstant: Opacity<Double> = .one,
            nonstrokingAlphaConstant: Opacity<Double> = .one,
            alphaSource: Bool = false,
            blackPointCompensation: ISO_32000.`8`.`4`.Graphics.State.BlackPoint.Compensation =
                .default
        ) {
            self.ctm = ctm
            self.strokingColorSpace = strokingColorSpace
            self.nonstrokingColorSpace = nonstrokingColorSpace
            self.strokingColor = strokingColor
            self.nonstrokingColor = nonstrokingColor
            self.textState = textState
            self.lineWidth = lineWidth
            self.lineCap = lineCap
            self.lineJoin = lineJoin
            self.miterLimit = miterLimit
            self.dashPattern = dashPattern
            self.renderingIntent = renderingIntent
            self.strokeAdjustment = strokeAdjustment
            self.blendMode = blendMode
            self.softMask = softMask
            self.strokingAlphaConstant = strokingAlphaConstant
            self.nonstrokingAlphaConstant = nonstrokingAlphaConstant
            self.alphaSource = alphaSource
            self.blackPointCompensation = blackPointCompensation
        }
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Device {

    public struct Dependent: Sendable {

        public var strokingOverprint: Bool

        public var nonstrokingOverprint: Bool

        public var overprintMode: Int

        public var blackGeneration: ISO_32000.`8`.`4`.Graphics.State.FunctionOrDefault

        public var undercolorRemoval: ISO_32000.`8`.`4`.Graphics.State.FunctionOrDefault

        @available(*, deprecated, message: "Deprecated in PDF 2.0")
        public var transfer: ISO_32000.`8`.`4`.Graphics.State.FunctionOrDefault

        public var halftone: ISO_32000.`8`.`4`.Graphics.State.HalftoneOrDefault

        public var halftoneOrigin: ISO_32000.`8`.`3`.`2`.`3`.UserSpace.Coordinate?

        public var flatness: Double

        public var smoothness: Double?

        public init() {
            self.strokingOverprint = false
            self.nonstrokingOverprint = false
            self.overprintMode = 0
            self.blackGeneration = .default
            self.undercolorRemoval = .default
            self.transfer = .default
            self.halftone = .default
            self.halftoneOrigin = nil
            self.flatness = 1.0
            self.smoothness = nil
        }
    }
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public enum FunctionOrDefault: Sendable, Hashable {

        case `default`

        case identity

        case function(FunctionReference)
    }

    public struct FunctionReference: Sendable, Hashable {

        public var type: FunctionType

        public init(type: FunctionType) {
            self.type = type
        }
    }

    public enum FunctionType: Int, Sendable, Codable, Hashable {

        case sampled = 0

        case exponentialInterpolation = 2

        case stitching = 3

        case postScriptCalculator = 4
    }

    public enum HalftoneOrDefault: Sendable, Hashable {

        case `default`

        case halftone(HalftoneReference)
    }

    public struct HalftoneReference: Sendable, Hashable {

        public var type: HalftoneType

        public init(type: HalftoneType) {
            self.type = type
        }
    }

    public enum HalftoneType: Int, Sendable, Codable, Hashable {

        case type1 = 1

        case type5 = 5

        case type6 = 6

        case type10 = 10

        case type16 = 16
    }

    public struct SoftMask: Sendable, Hashable {

        public var subtype: SoftMaskSubtype

        public init(subtype: SoftMaskSubtype) {
            self.subtype = subtype
        }
    }

    public enum SoftMaskSubtype: String, Sendable, Codable, Hashable {

        case alpha = "Alpha"

        case luminosity = "Luminosity"
    }

    public enum ColorSpace: Sendable, Hashable {

        case deviceGray
        case deviceRGB
        case deviceCMYK

        case calGray
        case calRGB
        case lab
        case iccBased

        case indexed
        case pattern
        case separation
        case deviceN
    }

    public enum Color: Sendable, Hashable {

        case gray(Double)

        case rgb(r: Double, g: Double, b: Double)

        case cmyk(c: Double, m: Double, y: Double, k: Double)
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Color {

    public static let black = ISO_32000.`8`.`4`.Graphics.State.Color.gray(0)

    public static let white = ISO_32000.`8`.`4`.Graphics.State.Color.gray(1)
}

extension ISO_32000.`8`.`4`.Graphics.State {

    public struct Stack<State: Sendable>: Sendable {

        private var states: [State]

        public init(initial: State) {
            self.states = [initial]
        }

        public var current: State {
            get { states[states.count - 1] }
            set { states[states.count - 1] = newValue }
        }

        public var depth: Int {
            states.count
        }

        public mutating func save() {
            states.append(current)
        }

        @discardableResult
        public mutating func restore() -> Bool {
            guard states.count > 1 else { return false }
            states.removeLast()
            return true
        }

        public mutating func withSavedState<T, E: Swift.Error>(
            _ body: (inout Self) throws(E) -> T
        ) throws(E) -> T {
            save()
            defer { restore() }
            return try body(&self)
        }
    }
}

extension ISO_32000.`8`.`4` {

    public enum Operator: Sendable, Hashable {

        case q

        case Q

        case cm(a: Double, b: Double, c: Double, d: Double, e: Double, f: Double)

        case w(lineWidth: Double)

        case J(lineCap: Graphics.State.Line.Cap)

        case j(lineJoin: Graphics.State.Line.Join)

        case M(miterLimit: Double)

        case d(dashArray: [Double], dashPhase: Double)

        case ri(intent: Graphics.State.Rendering.Intent)

        case i(flatness: Double)

        case gs(dictName: String)
    }
}

extension ISO_32000.`8`.`4`.Graphics.State.Device.Independent: Equatable
where TextState: Equatable {}

extension ISO_32000.`8`.`4`.Graphics.State.Device.Dependent: Equatable {}

extension ISO_32000.`8`.`4`.Graphics.State.Stack: Equatable
where State: Equatable {}

extension ISO_32000.`8`.`4`.Graphics.State.Device.Independent: Hashable
where TextState: Hashable {}

extension ISO_32000.`8`.`4`.Graphics.State.Device.Dependent: Hashable {}

extension ISO_32000.`8`.`4`.Graphics.State.Stack: Hashable
where State: Hashable {}

extension ISO_32000.`8`.`4`.Graphics.State.Stack {

    @inlinable
    public mutating func concatenate<TextState>(
        _ transform: ISO_32000.UserSpace.Transform
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.ctm = current.ctm.concatenating(transform)
    }

    @inlinable
    public mutating func translate<TextState>(
        dx: ISO_32000.UserSpace.Dx,
        dy: ISO_32000.UserSpace.Dy
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        concatenate(.translation(dx: dx, dy: dy))
    }

    @inlinable
    public mutating func scale<TextState>(
        x: ISO_32000.UserSpace.X,
        y: ISO_32000.UserSpace.Y
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        concatenate(.scale(x: x, y: y))
    }

    @inlinable
    public mutating func rotate<TextState>(
        _ angle: Radian<Double>
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        concatenate(.rotation(angle))
    }

    @inlinable
    public mutating func setFillColor<TextState>(
        _ color: ISO_32000.`8`.`4`.Graphics.State.Color
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.nonstrokingColor = color
    }

    @inlinable
    public mutating func setStrokeColor<TextState>(
        _ color: ISO_32000.`8`.`4`.Graphics.State.Color
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.strokingColor = color
    }

    @inlinable
    public mutating func setLineWidth<TextState>(
        _ width: ISO_32000.UserSpace.Width
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.lineWidth = width
    }

    @inlinable
    public mutating func setLineCap<TextState>(
        _ cap: ISO_32000.`8`.`4`.Graphics.State.Line.Cap
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.lineCap = cap
    }

    @inlinable
    public mutating func setLineJoin<TextState>(
        _ join: ISO_32000.`8`.`4`.Graphics.State.Line.Join
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.lineJoin = join
    }

    @inlinable
    public mutating func setDashPattern<TextState>(
        _ pattern: ISO_32000.`8`.`4`.Graphics.State.Line.Dash.Pattern
    ) where State == ISO_32000.`8`.`4`.Graphics.State.Device.Independent<TextState> {
        current.dashPattern = pattern
    }

    @inlinable
    public func extract() -> State {
        current
    }

    @inlinable
    public mutating func duplicate() {
        save()
    }

    @inlinable
    public func extend<T>(_ f: (Self) -> T) -> T {
        f(self)
    }
}
