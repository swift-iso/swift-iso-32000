public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


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
