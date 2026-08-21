public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `7` {}
}

extension ISO_32000 {

    public enum Form {}
}

extension ISO_32000.Form {

    public struct AcroForm: Sendable, Hashable {

        public var fields: [Int]

        public var needAppearances: Bool

        public var sigFlags: SigOptions

        public var calculationOrder: [Int]?

        public var defaultResources: Int?

        public var defaultAppearance: String?

        public var defaultQuadding: Quadding?

        public init(
            fields: [Int],
            needAppearances: Bool = false,
            sigFlags: SigOptions = [],
            calculationOrder: [Int]? = nil,
            defaultResources: Int? = nil,
            defaultAppearance: String? = nil,
            defaultQuadding: Quadding? = nil
        ) {
            self.fields = fields
            self.needAppearances = needAppearances
            self.sigFlags = sigFlags
            self.calculationOrder = calculationOrder
            self.defaultResources = defaultResources
            self.defaultAppearance = defaultAppearance
            self.defaultQuadding = defaultQuadding
        }
    }
}

extension ISO_32000.Form {

    public struct SigOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.SigOptions {

    public static let signaturesExist = ISO_32000.Form.SigOptions(rawValue: 1 << 0)

    public static let appendOnly = ISO_32000.Form.SigOptions(rawValue: 1 << 1)
}

extension ISO_32000.Form {

    public enum Quadding: Int, Sendable, Hashable, Codable, CaseIterable {

        case left = 0

        case center = 1

        case right = 2
    }
}

extension ISO_32000.Form {

    public struct Field: Sendable, Hashable {

        public var parent: Int?

        public var kids: [Int]?

        public var fieldType: FieldType?

        public var partialName: String?

        public var alternateName: String?

        public var mappingName: String?

        public var flags: FieldOptions

        public var value: FieldValue?

        public var defaultValue: FieldValue?

        public var additionalActions: Int?

        public var content: Content

        public init(
            parent: Int? = nil,
            kids: [Int]? = nil,
            fieldType: FieldType? = nil,
            partialName: String? = nil,
            alternateName: String? = nil,
            mappingName: String? = nil,
            flags: FieldOptions = [],
            value: FieldValue? = nil,
            defaultValue: FieldValue? = nil,
            additionalActions: Int? = nil,
            content: Content
        ) {
            self.parent = parent
            self.kids = kids
            self.fieldType = fieldType
            self.partialName = partialName
            self.alternateName = alternateName
            self.mappingName = mappingName
            self.flags = flags
            self.value = value
            self.defaultValue = defaultValue
            self.additionalActions = additionalActions
            self.content = content
        }
    }
}

extension ISO_32000.Form.Field {

    public enum FieldType: String, Sendable, Hashable, Codable, CaseIterable {

        case button = "Btn"

        case text = "Tx"

        case choice = "Ch"

        case signature = "Sig"
    }
}

extension ISO_32000.Form.Field {

    public enum FieldValue: Sendable, Hashable {

        case text(String)

        case name(String)

        case array([String])

        case stream(Int)
    }
}

extension ISO_32000.Form.Field {

    public enum Content: Sendable, Hashable {

        case button(Button)

        case text(Text)

        case choice(Choice)

        case signature(Signature)

        case container
    }
}

extension ISO_32000.Form.Field {

    public struct FieldOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.Field.FieldOptions {

    public static let readOnly = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 0)

    public static let required = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 1)

    public static let noExport = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 2)
}

extension ISO_32000.Form.Field {

    public struct Button: Sendable, Hashable {

        public var flags: ButtonOptions

        public var normalCaption: String?

        public var rolloverCaption: String?

        public var downCaption: String?

        public var normalIcon: Int?

        public var rolloverIcon: Int?

        public var downIcon: Int?

        public var iconFit: IconFit?

        public var textPosition: TextPosition

        public var options: [String]?

        public init(
            flags: ButtonOptions = [],
            normalCaption: String? = nil,
            rolloverCaption: String? = nil,
            downCaption: String? = nil,
            normalIcon: Int? = nil,
            rolloverIcon: Int? = nil,
            downIcon: Int? = nil,
            iconFit: IconFit? = nil,
            textPosition: TextPosition = .captionOnly,
            options: [String]? = nil
        ) {
            self.flags = flags
            self.normalCaption = normalCaption
            self.rolloverCaption = rolloverCaption
            self.downCaption = downCaption
            self.normalIcon = normalIcon
            self.rolloverIcon = rolloverIcon
            self.downIcon = downIcon
            self.iconFit = iconFit
            self.textPosition = textPosition
            self.options = options
        }
    }
}

extension ISO_32000.Form.Field.Button {

    public struct ButtonOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.Field.Button.ButtonOptions {

    public static let noToggleToOff = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 14)

    public static let radio = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 15)

    public static let pushbutton = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 16)

    public static let radiosInUnison = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 25)
}

extension ISO_32000.Form.Field.Button {

    public enum TextPosition: Int, Sendable, Hashable, Codable, CaseIterable {

        case captionOnly = 0

        case iconOnly = 1

        case captionBelowIcon = 2

        case captionAboveIcon = 3

        case captionRightOfIcon = 4

        case captionLeftOfIcon = 5

        case captionOverIcon = 6
    }
}

extension ISO_32000.Form.Field.Button {

    public struct IconFit: Sendable, Hashable {

        public var scaleMode: ScaleMode

        public var proportional: Bool

        public var horizontalAlignment: Double

        public var verticalAlignment: Double

        public var fitToBounds: Bool

        public init(
            scaleMode: ScaleMode = .always,
            proportional: Bool = true,
            horizontalAlignment: Double = 0.5,
            verticalAlignment: Double = 0.5,
            fitToBounds: Bool = false
        ) {
            self.scaleMode = scaleMode
            self.proportional = proportional
            self.horizontalAlignment = horizontalAlignment
            self.verticalAlignment = verticalAlignment
            self.fitToBounds = fitToBounds
        }
    }
}

extension ISO_32000.Form.Field.Button.IconFit {

    public enum ScaleMode: String, Sendable, Hashable, Codable, CaseIterable {

        case always = "A"

        case bigger = "B"

        case smaller = "S"

        case never = "N"
    }
}

extension ISO_32000.Form.Field {

    public struct Text: Sendable, Hashable {

        public var flags: TextOptions

        public var maxLength: Int?

        public var defaultAppearance: String?

        public var quadding: ISO_32000.Form.Quadding

        public var richText: String?

        public var defaultStyle: String?

        public init(
            flags: TextOptions = [],
            maxLength: Int? = nil,
            defaultAppearance: String? = nil,
            quadding: ISO_32000.Form.Quadding = .left,
            richText: String? = nil,
            defaultStyle: String? = nil
        ) {
            self.flags = flags
            self.maxLength = maxLength
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
            self.richText = richText
            self.defaultStyle = defaultStyle
        }
    }
}

extension ISO_32000.Form.Field.Text {

    public struct TextOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.Field.Text.TextOptions {

    public static let multiline = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 12)

    public static let password = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 13)

    public static let fileSelect = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 20)

    public static let doNotSpellCheck = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 22)

    public static let doNotScroll = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 23)

    public static let comb = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 24)

    public static let richText = ISO_32000.Form.Field.Text.TextOptions(rawValue: 1 << 25)
}

extension ISO_32000.Form.Field {

    public struct Choice: Sendable, Hashable {

        public var flags: ChoiceOptions

        public var options: [Option]

        public var topIndex: Int?

        public var defaultAppearance: String?

        public var quadding: ISO_32000.Form.Quadding

        public init(
            flags: ChoiceOptions = [],
            options: [Option] = [],
            topIndex: Int? = nil,
            defaultAppearance: String? = nil,
            quadding: ISO_32000.Form.Quadding = .left
        ) {
            self.flags = flags
            self.options = options
            self.topIndex = topIndex
            self.defaultAppearance = defaultAppearance
            self.quadding = quadding
        }
    }
}

extension ISO_32000.Form.Field.Choice {

    public struct Option: Sendable, Hashable {

        public var exportValue: String

        public var displayValue: String

        public init(exportValue: String, displayValue: String? = nil) {
            self.exportValue = exportValue
            self.displayValue = displayValue ?? exportValue
        }
    }
}

extension ISO_32000.Form.Field.Choice {

    public struct ChoiceOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.Field.Choice.ChoiceOptions {

    public static let combo = ISO_32000.Form.Field.Choice.ChoiceOptions(rawValue: 1 << 17)

    public static let edit = ISO_32000.Form.Field.Choice.ChoiceOptions(rawValue: 1 << 18)

    public static let sort = ISO_32000.Form.Field.Choice.ChoiceOptions(rawValue: 1 << 19)

    public static let multiSelect = ISO_32000.Form.Field.Choice.ChoiceOptions(rawValue: 1 << 21)

    public static let doNotSpellCheck = ISO_32000.Form.Field.Choice.ChoiceOptions(rawValue: 1 << 22)

    public static let commitOnSelChange = ISO_32000.Form.Field.Choice.ChoiceOptions(
        rawValue: 1 << 26
    )
}

extension ISO_32000.Form.Field {

    public struct Signature: Sendable, Hashable {

        public var signatureValue: Int?

        public var seedValue: SeedValue?

        public var lock: Lock?

        public init(
            signatureValue: Int? = nil,
            seedValue: SeedValue? = nil,
            lock: Lock? = nil
        ) {
            self.signatureValue = signatureValue
            self.seedValue = seedValue
            self.lock = lock
        }
    }
}

extension ISO_32000.Form.Field.Signature {

    public struct SeedValue: Sendable, Hashable {

        public var flags: SeedOptions

        public var filter: String?

        public var subFilter: [String]?

        public var certConstraints: CertConstraints?

        public var digestMethod: [String]?

        public var reasons: [String]?

        public var legalAttestation: [String]?

        public var timeStampServer: String?

        public init(
            flags: SeedOptions = [],
            filter: String? = nil,
            subFilter: [String]? = nil,
            certConstraints: CertConstraints? = nil,
            digestMethod: [String]? = nil,
            reasons: [String]? = nil,
            legalAttestation: [String]? = nil,
            timeStampServer: String? = nil
        ) {
            self.flags = flags
            self.filter = filter
            self.subFilter = subFilter
            self.certConstraints = certConstraints
            self.digestMethod = digestMethod
            self.reasons = reasons
            self.legalAttestation = legalAttestation
            self.timeStampServer = timeStampServer
        }
    }
}

extension ISO_32000.Form.Field.Signature.SeedValue {

    public struct SeedOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    public struct CertConstraints: Sendable, Hashable {

        public var subject: [String]?

        public var issuer: [String]?

        public var oid: [String]?

        public var url: String?

        public init(
            subject: [String]? = nil,
            issuer: [String]? = nil,
            oid: [String]? = nil,
            url: String? = nil
        ) {
            self.subject = subject
            self.issuer = issuer
            self.oid = oid
            self.url = url
        }
    }
}

extension ISO_32000.Form.Field.Signature.SeedValue.SeedOptions {

    public static let filter = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 0
    )

    public static let subFilter = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 1
    )

    public static let version = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 2
    )

    public static let reasons = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 3
    )

    public static let legalAttestation = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 4
    )

    public static let addRevInfo = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 5
    )

    public static let digestMethod = ISO_32000.Form.Field.Signature.SeedValue.SeedOptions(
        rawValue: 1 << 6
    )
}

extension ISO_32000.Form.Field.Signature {

    public struct Lock: Sendable, Hashable {

        public var action: Action

        public var fields: [String]?

        public init(action: Action, fields: [String]? = nil) {
            self.action = action
            self.fields = fields
        }
    }
}

extension ISO_32000.Form.Field.Signature.Lock {

    public enum Action: String, Sendable, Hashable, Codable, CaseIterable {

        case all = "All"

        case include = "Include"

        case exclude = "Exclude"
    }
}

extension ISO_32000.Form {

    public struct SubmitForm: Sendable, Hashable {

        public var url: String

        public var fields: [String]?

        public var flags: SubmitOptions

        public init(url: String, fields: [String]? = nil, flags: SubmitOptions = []) {
            self.url = url
            self.fields = fields
            self.flags = flags
        }
    }

    public struct ResetForm: Sendable, Hashable {

        public var fields: [String]?

        public var exclude: Bool

        public init(fields: [String]? = nil, exclude: Bool = false) {
            self.fields = fields
            self.exclude = exclude
        }
    }

    public struct ImportData: Sendable, Hashable {

        public var file: String

        public init(file: String) {
            self.file = file
        }
    }
}

extension ISO_32000.Form.SubmitForm {

    public struct SubmitOptions: OptionSet, Sendable, Hashable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension ISO_32000.Form.SubmitForm.SubmitOptions {

    public static let exclude = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 0)

    public static let includeNoValueFields = ISO_32000.Form.SubmitForm.SubmitOptions(
        rawValue: 1 << 1
    )

    public static let exportFormat = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 2)

    public static let getMethod = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 3)

    public static let submitCoordinates = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 4)

    public static let xfdf = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 5)

    public static let includeAppendSaves = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 6)

    public static let includeAnnotations = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 7)

    public static let submitPDF = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 8)

    public static let canonicalFormat = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 9)

    public static let excludeNonUserAnnots = ISO_32000.Form.SubmitForm.SubmitOptions(
        rawValue: 1 << 10
    )

    public static let excludeFKey = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 11)

    public static let embedForm = ISO_32000.Form.SubmitForm.SubmitOptions(rawValue: 1 << 13)
}

extension ISO_32000.`12`.`5`.Annotation {

    public struct Widget: Sendable, Hashable {

        public var highlightMode: HighlightMode

        public var appearanceCharacteristics: AppearanceCharacteristics?

        public var action: Int?

        public var additionalActions: Int?

        public var borderStyle: ISO_32000.`12`.`5`.Border.Style?

        public init(
            highlightMode: HighlightMode = .invert,
            appearanceCharacteristics: AppearanceCharacteristics? = nil,
            action: Int? = nil,
            additionalActions: Int? = nil,
            borderStyle: ISO_32000.`12`.`5`.Border.Style? = nil
        ) {
            self.highlightMode = highlightMode
            self.appearanceCharacteristics = appearanceCharacteristics
            self.action = action
            self.additionalActions = additionalActions
            self.borderStyle = borderStyle
        }
    }
}

extension ISO_32000.`12`.`5`.Annotation.Widget {

    public enum HighlightMode: String, Sendable, Hashable, Codable, CaseIterable {

        case none = "N"

        case invert = "I"

        case outline = "O"

        case push = "P"

        case toggle = "T"
    }
}

extension ISO_32000.`12`.`5`.Annotation.Widget {

    public struct AppearanceCharacteristics: Sendable, Hashable {

        public var rotation: Int

        public var borderColor: ISO_32000.`12`.`5`.Annotation.Color?

        public var backgroundColor: ISO_32000.`12`.`5`.Annotation.Color?

        public var normalCaption: String?

        public var rolloverCaption: String?

        public var alternateCaption: String?

        public var normalIcon: Int?

        public var rolloverIcon: Int?

        public var alternateIcon: Int?

        public var iconFit: ISO_32000.Form.Field.Button.IconFit?

        public var textPosition: ISO_32000.Form.Field.Button.TextPosition

        public init(
            rotation: Int = 0,
            borderColor: ISO_32000.`12`.`5`.Annotation.Color? = nil,
            backgroundColor: ISO_32000.`12`.`5`.Annotation.Color? = nil,
            normalCaption: String? = nil,
            rolloverCaption: String? = nil,
            alternateCaption: String? = nil,
            normalIcon: Int? = nil,
            rolloverIcon: Int? = nil,
            alternateIcon: Int? = nil,
            iconFit: ISO_32000.Form.Field.Button.IconFit? = nil,
            textPosition: ISO_32000.Form.Field.Button.TextPosition = .captionOnly
        ) {
            self.rotation = rotation
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.normalCaption = normalCaption
            self.rolloverCaption = rolloverCaption
            self.alternateCaption = alternateCaption
            self.normalIcon = normalIcon
            self.rolloverIcon = rolloverIcon
            self.alternateIcon = alternateIcon
            self.iconFit = iconFit
            self.textPosition = textPosition
        }
    }
}

extension ISO_32000.`12`.`7` {

    public typealias AcroForm = ISO_32000.Form.AcroForm

    public typealias SigOptions = ISO_32000.Form.SigOptions

    public typealias Field = ISO_32000.Form.Field

    public typealias SubmitForm = ISO_32000.Form.SubmitForm

    public typealias ResetForm = ISO_32000.Form.ResetForm

    public typealias ImportData = ISO_32000.Form.ImportData
}
