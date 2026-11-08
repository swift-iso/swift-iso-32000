public import ISO_32000_Shared
public import RFC_3986


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
