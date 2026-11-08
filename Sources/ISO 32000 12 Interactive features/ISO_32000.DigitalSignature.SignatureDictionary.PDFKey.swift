public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureDictionary {
    public enum PDFKey: String, CodingKey {
        case type = "Type"
        case filter = "Filter"
        case subFilter = "SubFilter"
        case contents = "Contents"
        case cert = "Cert"
        case byteRange = "ByteRange"
        case reference = "Reference"
        case changes = "Changes"
        case name = "Name"
        case signingTime = "M"
        case location = "Location"
        case reason = "Reason"
        case contactInfo = "ContactInfo"
        case handlerVersion = "R"
        case formatVersion = "V"
        case propBuild = "Prop_Build"
        case propAuthTime = "Prop_AuthTime"
        case propAuthType = "Prop_AuthType"
    }
}
