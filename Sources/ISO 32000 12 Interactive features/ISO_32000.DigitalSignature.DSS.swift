public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


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
