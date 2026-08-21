public import Byte_Primitives
public import ISO_32000_7_Syntax
public import ISO_32000_Shared

extension ISO_32000.`12` {

    public enum `8` {}
}

extension ISO_32000 {

    public enum DigitalSignature {}
}

extension ISO_32000.DigitalSignature {

    public struct SignatureDictionary: Sendable, Hashable {

        public var type: DictionaryType

        public var filter: String

        public var subFilter: SubFilter?

        public var contents: [Byte]

        public var cert: CertValue?

        public var byteRange: [ByteRangePair]?

        public var reference: [SignatureReference]?

        public var changes: Changes?

        public var name: String?

        public var signingTime: ISO_32000.`7`.`9`.`4`.Date?

        public var location: String?

        public var reason: String?

        public var contactInfo: String?

        public var handlerVersion: Int?

        public var formatVersion: Int

        public var propBuild: Int?

        public var propAuthTime: Int?

        public var propAuthType: AuthType?

        public init(
            type: DictionaryType = .sig,
            filter: String,
            subFilter: SubFilter? = nil,
            contents: [Byte],
            cert: CertValue? = nil,
            byteRange: [ByteRangePair]? = nil,
            reference: [SignatureReference]? = nil,
            changes: Changes? = nil,
            name: String? = nil,
            signingTime: ISO_32000.`7`.`9`.`4`.Date? = nil,
            location: String? = nil,
            reason: String? = nil,
            contactInfo: String? = nil,
            handlerVersion: Int? = nil,
            formatVersion: Int = 0,
            propBuild: Int? = nil,
            propAuthTime: Int? = nil,
            propAuthType: AuthType? = nil
        ) {
            self.type = type
            self.filter = filter
            self.subFilter = subFilter
            self.contents = contents
            self.cert = cert
            self.byteRange = byteRange
            self.reference = reference
            self.changes = changes
            self.name = name
            self.signingTime = signingTime
            self.location = location
            self.reason = reason
            self.contactInfo = contactInfo
            self.handlerVersion = handlerVersion
            self.formatVersion = formatVersion
            self.propBuild = propBuild
            self.propAuthTime = propAuthTime
            self.propAuthType = propAuthType
        }
    }
}

extension ISO_32000.DigitalSignature.SignatureDictionary {

    public enum PDFKey: String, CodingKey {
        case type = "Type"
        case filter = "Filter"
        case subFilter = "SubFilter"
        case contents = "Contents"
        case cert = "Cert"
        case byteRange = "ByteRange"
        case reference = "Reference"
        case changes = "Changes"
        case name = "Name"
        case signingTime = "M"
        case location = "Location"
        case reason = "Reason"
        case contactInfo = "ContactInfo"
        case handlerVersion = "R"
        case formatVersion = "V"
        case propBuild = "Prop_Build"
        case propAuthTime = "Prop_AuthTime"
        case propAuthType = "Prop_AuthType"
    }
}

extension ISO_32000.DigitalSignature.SignatureDictionary {

    public enum DictionaryType: String, Sendable, Hashable, Codable, CaseIterable {

        case sig = "Sig"

        case docTimeStamp = "DocTimeStamp"
    }

    public enum SubFilter: String, Sendable, Hashable, Codable, CaseIterable {

        case adbeX509RsaSha1 = "adbe.x509.rsa_sha1"

        case adbePkcs7Detached = "adbe.pkcs7.detached"

        case adbePkcs7Sha1 = "adbe.pkcs7.sha1"

        case etsiCadesDetached = "ETSI.CAdES.detached"

        case etsiRfc3161 = "ETSI.RFC3161"
    }

    public enum CertValue: Sendable, Hashable {

        case single([Byte])

        case chain([[Byte]])
    }

    public struct ByteRangePair: Sendable, Hashable {
        public var offset: Int
        public var length: Int

        public init(offset: Int, length: Int) {
            self.offset = offset
            self.length = length
        }
    }

    public struct Changes: Sendable, Hashable {
        public var pagesAltered: Int
        public var fieldsAltered: Int
        public var fieldsFilled: Int

        public init(pagesAltered: Int, fieldsAltered: Int, fieldsFilled: Int) {
            self.pagesAltered = pagesAltered
            self.fieldsAltered = fieldsAltered
            self.fieldsFilled = fieldsFilled
        }
    }

    public enum AuthType: String, Sendable, Hashable, Codable, CaseIterable {
        case pin = "PIN"
        case password = "Password"
        case fingerprint = "Fingerprint"
    }
}

extension ISO_32000.DigitalSignature {

    public struct SignatureReference: Sendable, Hashable {

        public var transformMethod: TransformMethod

        public var transformParams: TransformParams?

        public var data: Int?

        public var digestMethod: DigestMethod

        public init(
            transformMethod: TransformMethod,
            transformParams: TransformParams? = nil,
            data: Int? = nil,
            digestMethod: DigestMethod
        ) {
            self.transformMethod = transformMethod
            self.transformParams = transformParams
            self.data = data
            self.digestMethod = digestMethod
        }
    }
}

extension ISO_32000.DigitalSignature.SignatureReference {

    public enum TransformMethod: String, Sendable, Hashable, Codable, CaseIterable {

        case docMDP = "DocMDP"

        case ur = "UR"

        case fieldMDP = "FieldMDP"
    }

    public enum TransformParams: Sendable, Hashable {
        case docMDP(DocMDPParams)
        case ur(URParams)
        case fieldMDP(FieldMDPParams)
    }

    public enum DigestMethod: String, Sendable, Hashable, Codable, CaseIterable {

        case md5 = "MD5"

        case sha1 = "SHA1"

        case sha256 = "SHA256"

        case sha384 = "SHA384"

        case sha512 = "SHA512"

        case ripemd160 = "RIPEMD160"
    }
}

extension ISO_32000.DigitalSignature.SignatureReference {

    public struct DocMDPParams: Sendable, Hashable {

        public var permissions: Permission

        public var version: String

        public init(
            permissions: Permission = .formFillingAndSigning,
            version: String = "1.2"
        ) {
            self.permissions = permissions
            self.version = version
        }
    }
}

extension ISO_32000.DigitalSignature.SignatureReference.DocMDPParams {

    public enum Permission: Int, Sendable, Hashable, Codable, CaseIterable {

        case noChanges = 1

        case formFillingAndSigning = 2

        case formFillingSigningAndAnnotations = 3
    }
}

extension ISO_32000.DigitalSignature.SignatureReference {

    public struct URParams: Sendable, Hashable {

        public var document: DocumentRights

        public var message: String?

        public var version: String

        public var annots: AnnotRights

        public var form: FormRights

        public var signature: SignatureRights

        public var embeddedFiles: EmbeddedFileRights

        public var enforceRestrictions: Bool

        public init(
            document: DocumentRights = [],
            message: String? = nil,
            version: String = "2.2",
            annots: AnnotRights = [],
            form: FormRights = [],
            signature: SignatureRights = [],
            embeddedFiles: EmbeddedFileRights = [],
            enforceRestrictions: Bool = false
        ) {
            self.document = document
            self.message = message
            self.version = version
            self.annots = annots
            self.form = form
            self.signature = signature
            self.embeddedFiles = embeddedFiles
            self.enforceRestrictions = enforceRestrictions
        }
    }
}

extension ISO_32000.DigitalSignature.SignatureReference.URParams {

    public struct DocumentRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }

    public struct AnnotRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }

    public struct FormRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }

    public struct SignatureRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }

    public struct EmbeddedFileRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }
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

    public struct FieldMDPParams: Sendable, Hashable {

        public var action: Action

        public var fields: [String]?

        public var version: String

        public init(
            action: Action,
            fields: [String]? = nil,
            version: String = "1.2"
        ) {
            self.action = action
            self.fields = fields
            self.version = version
        }
    }
}

extension ISO_32000.DigitalSignature.SignatureReference.FieldMDPParams {

    public enum Action: String, Sendable, Hashable, Codable, CaseIterable {

        case all = "All"

        case include = "Include"

        case exclude = "Exclude"
    }
}

extension ISO_32000.DigitalSignature {

    public struct DSS: Sendable, Hashable {

        public var vri: [String: VRI]?

        public var certs: [Int]?

        public var ocsps: [Int]?

        public var crls: [Int]?

        public init(
            vri: [String: VRI]? = nil,
            certs: [Int]? = nil,
            ocsps: [Int]? = nil,
            crls: [Int]? = nil
        ) {
            self.vri = vri
            self.certs = certs
            self.ocsps = ocsps
            self.crls = crls
        }
    }
}

extension ISO_32000.DigitalSignature {

    public struct VRI: Sendable, Hashable {

        public var cert: [Int]?

        public var crl: [Int]?

        public var ocsp: [Int]?

        public var createdTime: ISO_32000.`7`.`9`.`4`.Date?

        public var timestamp: Int?

        public init(
            cert: [Int]? = nil,
            crl: [Int]? = nil,
            ocsp: [Int]? = nil,
            createdTime: ISO_32000.`7`.`9`.`4`.Date? = nil,
            timestamp: Int? = nil
        ) {
            self.cert = cert
            self.crl = crl
            self.ocsp = ocsp
            self.createdTime = createdTime
            self.timestamp = timestamp
        }
    }
}

extension ISO_32000.DigitalSignature.VRI {

    public enum PDFKey: String, CodingKey {
        case cert = "Cert"
        case crl = "CRL"
        case ocsp = "OCSP"
        case createdTime = "TU"
        case timestamp = "TS"
    }
}

extension ISO_32000.DigitalSignature {

    public struct Permissions: Sendable, Hashable {

        public var docMDP: Int?

        public var ur3: Int?

        public init(
            docMDP: Int? = nil,
            ur3: Int? = nil
        ) {
            self.docMDP = docMDP
            self.ur3 = ur3
        }
    }
}

extension ISO_32000.DigitalSignature {

    public struct LegalAttestation: Sendable, Hashable {

        public var javaScriptActions: Int?

        public var launchActions: Int?

        public var uriActions: Int?

        public var movieActions: Int?

        public var soundActions: Int?

        public var hideAnnotationActions: Int?

        public var goToRemoteActions: Int?

        public var alternateImages: Int?

        public var externalStreams: Int?

        public var trueTypeFonts: Int?

        public var externalRefXobjects: Int?

        public var externalOPIdicts: Int?

        public var nonEmbeddedFonts: Int?

        public var devDepGS_OP: Int?

        public var devDepGS_HT: Int?

        public var devDepGS_TR: Int?

        public var devDepGS_UCR: Int?

        public var devDepGS_BG: Int?

        public var devDepGS_FL: Int?

        public var annotations: Int?

        public var optionalContent: Bool?

        public var attestation: String?

        public init(
            javaScriptActions: Int? = nil,
            launchActions: Int? = nil,
            uriActions: Int? = nil,
            movieActions: Int? = nil,
            soundActions: Int? = nil,
            hideAnnotationActions: Int? = nil,
            goToRemoteActions: Int? = nil,
            alternateImages: Int? = nil,
            externalStreams: Int? = nil,
            trueTypeFonts: Int? = nil,
            externalRefXobjects: Int? = nil,
            externalOPIdicts: Int? = nil,
            nonEmbeddedFonts: Int? = nil,
            devDepGS_OP: Int? = nil,
            devDepGS_HT: Int? = nil,
            devDepGS_TR: Int? = nil,
            devDepGS_UCR: Int? = nil,
            devDepGS_BG: Int? = nil,
            devDepGS_FL: Int? = nil,
            annotations: Int? = nil,
            optionalContent: Bool? = nil,
            attestation: String? = nil
        ) {
            self.javaScriptActions = javaScriptActions
            self.launchActions = launchActions
            self.uriActions = uriActions
            self.movieActions = movieActions
            self.soundActions = soundActions
            self.hideAnnotationActions = hideAnnotationActions
            self.goToRemoteActions = goToRemoteActions
            self.alternateImages = alternateImages
            self.externalStreams = externalStreams
            self.trueTypeFonts = trueTypeFonts
            self.externalRefXobjects = externalRefXobjects
            self.externalOPIdicts = externalOPIdicts
            self.nonEmbeddedFonts = nonEmbeddedFonts
            self.devDepGS_OP = devDepGS_OP
            self.devDepGS_HT = devDepGS_HT
            self.devDepGS_TR = devDepGS_TR
            self.devDepGS_UCR = devDepGS_UCR
            self.devDepGS_BG = devDepGS_BG
            self.devDepGS_FL = devDepGS_FL
            self.annotations = annotations
            self.optionalContent = optionalContent
            self.attestation = attestation
        }
    }
}

extension ISO_32000.`12`.`8` {

    public typealias SignatureDictionary = ISO_32000.DigitalSignature.SignatureDictionary

    public typealias SignatureReference = ISO_32000.DigitalSignature.SignatureReference

    public typealias DSS = ISO_32000.DigitalSignature.DSS

    public typealias VRI = ISO_32000.DigitalSignature.VRI

    public typealias Permissions = ISO_32000.DigitalSignature.Permissions

    public typealias LegalAttestation = ISO_32000.DigitalSignature.LegalAttestation
}
