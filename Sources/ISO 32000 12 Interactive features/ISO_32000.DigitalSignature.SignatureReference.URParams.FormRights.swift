public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference.URParams {
    public struct FormRights: OptionSet, Sendable, Hashable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
    }
}
