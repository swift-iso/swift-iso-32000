public import ISO_32000_Shared
public import RFC_3986

extension ISO_32000.`12` {

    public enum `7` {}
}

extension ISO_32000 {
}

extension ISO_32000.Form {
}

extension ISO_32000.Form {
}

extension ISO_32000.Form.SigOptions {

    public static let signaturesExist = ISO_32000.Form.SigOptions(rawValue: 1 << 0)

    public static let appendOnly = ISO_32000.Form.SigOptions(rawValue: 1 << 1)
}

extension ISO_32000.Form {
}

extension ISO_32000.Form {
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field.FieldOptions {

    public static let readOnly = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 0)

    public static let required = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 1)

    public static let noExport = ISO_32000.Form.Field.FieldOptions(rawValue: 1 << 2)
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field.Button {
}

extension ISO_32000.Form.Field.Button.ButtonOptions {

    public static let noToggleToOff = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 14)

    public static let radio = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 15)

    public static let pushbutton = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 16)

    public static let radiosInUnison = ISO_32000.Form.Field.Button.ButtonOptions(rawValue: 1 << 25)
}

extension ISO_32000.Form.Field.Button {
}

extension ISO_32000.Form.Field.Button {
}

extension ISO_32000.Form.Field.Button.IconFit {
}

extension ISO_32000.Form.Field {
}

extension ISO_32000.Form.Field.Text {
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
}

extension ISO_32000.Form.Field.Choice {
}

extension ISO_32000.Form.Field.Choice {
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
}

extension ISO_32000.Form.Field.Signature {
}

extension ISO_32000.Form.Field.Signature.SeedValue {
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
}

extension ISO_32000.Form.Field.Signature.Lock {
}

extension ISO_32000.Form {
}

extension ISO_32000.Form.SubmitForm {
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
}

extension ISO_32000.`12`.`5`.Annotation.Widget {
}

extension ISO_32000.`12`.`5`.Annotation.Widget {
}

extension ISO_32000.`12`.`7` {

    public typealias AcroForm = ISO_32000.Form.AcroForm

    public typealias SigOptions = ISO_32000.Form.SigOptions

    public typealias Field = ISO_32000.Form.Field

    public typealias SubmitForm = ISO_32000.Form.SubmitForm

    public typealias ResetForm = ISO_32000.Form.ResetForm

    public typealias ImportData = ISO_32000.Form.ImportData
}
