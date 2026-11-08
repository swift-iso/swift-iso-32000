public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureDictionary {
    public enum AuthType: String, Sendable, Hashable, Codable, CaseIterable {
        case pin = "PIN"
        case password = "Password"
        case fingerprint = "Fingerprint"
    }
}
