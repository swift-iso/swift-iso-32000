public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureDictionary {
    public enum SubFilter: String, Sendable, Hashable, Codable, CaseIterable {

        case adbeX509RsaSha1 = "adbe.x509.rsa_sha1"

        case adbePkcs7Detached = "adbe.pkcs7.detached"

        case adbePkcs7Sha1 = "adbe.pkcs7.sha1"

        case etsiCadesDetached = "ETSI.CAdES.detached"

        case etsiRfc3161 = "ETSI.RFC3161"
    }
}
