public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference {
    public struct FieldMDPParams: Sendable, Hashable {

        public var action: Action

        public var fields: [String]?

        // swift-linter:disable:next raw concept
        // REASON: A PDF signature dictionary's /V version name such as 1.2 or 2.2, which is two components of PDF's own numbering; looked at Version.Semantic (needs three) and Version.Tools (a Swift tools version), neither is what ISO 32000 defines.
        public var version: String

        public init(
            action: Action,
            fields: [String]? = nil,
            // swift-linter:disable:next raw concept
            // REASON: A PDF signature dictionary's /V version name such as 1.2 or 2.2, which is two components of PDF's own numbering; looked at Version.Semantic (needs three) and Version.Tools (a Swift tools version), neither is what ISO 32000 defines.
            version: String = "1.2"
        ) {
            self.action = action
            self.fields = fields
            self.version = version
        }
    }
}
