public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `8` {}
}

extension ISO_32000 {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.DigitalSignature.SignatureDictionary {
}

extension ISO_32000.DigitalSignature.SignatureDictionary {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.DigitalSignature.SignatureReference {
}

extension ISO_32000.DigitalSignature.SignatureReference {
}

extension ISO_32000.DigitalSignature.SignatureReference.DocMDPParams {
}

extension ISO_32000.DigitalSignature.SignatureReference {
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams {
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams.DocumentRights {

    public static let fullSave = ISO_32000.DigitalSignature.SignatureReference.URParams
        .DocumentRights(rawValue: 1 << 0)
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights {
    public static let create = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 0
    )
    public static let delete = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 1
    )
    public static let modify = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 2
    )
    public static let copy = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 3
    )
    public static let `import` = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 4
    )
    public static let export = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 5
    )

    public static let online = ISO_32000.DigitalSignature.SignatureReference.URParams.AnnotRights(
        rawValue: 1 << 6
    )

    public static let summaryView = ISO_32000.DigitalSignature.SignatureReference.URParams
        .AnnotRights(rawValue: 1 << 7)
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights {
    public static let add = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 0
    )
    public static let delete = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 1
    )
    public static let fillIn = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 2
    )
    public static let `import` = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 3
    )
    public static let export = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 4
    )
    public static let submitStandalone = ISO_32000.DigitalSignature.SignatureReference.URParams
        .FormRights(rawValue: 1 << 5)
    public static let spawnTemplate = ISO_32000.DigitalSignature.SignatureReference.URParams
        .FormRights(rawValue: 1 << 6)

    public static let barcodePlaintext = ISO_32000.DigitalSignature.SignatureReference.URParams
        .FormRights(rawValue: 1 << 7)

    public static let online = ISO_32000.DigitalSignature.SignatureReference.URParams.FormRights(
        rawValue: 1 << 8
    )
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams.SignatureRights {

    public static let modify = ISO_32000.DigitalSignature.SignatureReference.URParams
        .SignatureRights(rawValue: 1 << 0)
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams.EmbeddedFileRights {
    public static let create = ISO_32000.DigitalSignature.SignatureReference.URParams
        .EmbeddedFileRights(rawValue: 1 << 0)
    public static let delete = ISO_32000.DigitalSignature.SignatureReference.URParams
        .EmbeddedFileRights(rawValue: 1 << 1)
    public static let modify = ISO_32000.DigitalSignature.SignatureReference.URParams
        .EmbeddedFileRights(rawValue: 1 << 2)
    public static let `import` = ISO_32000.DigitalSignature.SignatureReference.URParams
        .EmbeddedFileRights(rawValue: 1 << 3)
}

extension ISO_32000.DigitalSignature.SignatureReference {
}

extension ISO_32000.DigitalSignature.SignatureReference.FieldMDPParams {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.DigitalSignature.VRI {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.DigitalSignature {
}

extension ISO_32000.`12`.`8` {

    public typealias SignatureDictionary = ISO_32000.DigitalSignature.SignatureDictionary

    public typealias SignatureReference = ISO_32000.DigitalSignature.SignatureReference

    public typealias DSS = ISO_32000.DigitalSignature.DSS

    public typealias VRI = ISO_32000.DigitalSignature.VRI

    public typealias Permissions = ISO_32000.DigitalSignature.Permissions

    public typealias LegalAttestation = ISO_32000.DigitalSignature.LegalAttestation
}
