public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference {
    public enum DigestMethod: String, Sendable, Hashable, Codable, CaseIterable {

        case md5 = "MD5"

        case sha1 = "SHA1"

        case sha256 = "SHA256"

        case sha384 = "SHA384"

        case sha512 = "SHA512"

        case ripemd160 = "RIPEMD160"
    }
}
