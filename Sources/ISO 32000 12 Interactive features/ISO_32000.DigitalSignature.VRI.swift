public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


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
