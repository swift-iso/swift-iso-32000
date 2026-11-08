public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference {
    public struct URParams: Sendable, Hashable {

        public var document: DocumentRights

        public var message: String?

        // swift-linter:disable:next raw concept
        // REASON: A PDF signature dictionary's /V version name such as 1.2 or 2.2, which is two components of PDF's own numbering; looked at Version.Semantic (needs three) and Version.Tools (a Swift tools version), neither is what ISO 32000 defines.
        public var version: String

        public var annots: AnnotRights

        public var form: FormRights

        public var signature: SignatureRights

        public var embeddedFiles: EmbeddedFileRights

        public var enforceRestrictions: Bool

        public init(
            document: DocumentRights = [],
            message: String? = nil,
            // swift-linter:disable:next raw concept
            // REASON: A PDF signature dictionary's /V version name such as 1.2 or 2.2, which is two components of PDF's own numbering; looked at Version.Semantic (needs three) and Version.Tools (a Swift tools version), neither is what ISO 32000 defines.
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
