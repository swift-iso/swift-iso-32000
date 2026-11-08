public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


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
