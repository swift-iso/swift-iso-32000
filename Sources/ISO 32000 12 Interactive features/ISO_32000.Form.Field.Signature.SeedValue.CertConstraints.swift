public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field.Signature.SeedValue {
    public struct CertConstraints: Sendable, Hashable {

        public var subject: [String]?

        public var issuer: [String]?

        public var oid: [String]?

        public var url: RFC_3986.URI?

        public init(
            subject: [String]? = nil,
            issuer: [String]? = nil,
            oid: [String]? = nil,
            url: RFC_3986.URI? = nil
        ) {
            self.subject = subject
            self.issuer = issuer
            self.oid = oid
            self.url = url
        }
    }
}
