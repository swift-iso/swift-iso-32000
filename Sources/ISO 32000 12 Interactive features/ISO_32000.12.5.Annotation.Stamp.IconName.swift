public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5`.Annotation.Stamp {
    public enum IconName: String, Sendable, Hashable, Codable, CaseIterable {
        case approved = "Approved"
        case experimental = "Experimental"
        case notApproved = "NotApproved"
        case asIs = "AsIs"
        case expired = "Expired"
        case notForPublicRelease = "NotForPublicRelease"
        case confidential = "Confidential"
        case final = "Final"
        case sold = "Sold"
        case departmental = "Departmental"
        case forComment = "ForComment"
        case topSecret = "TopSecret"
        case draft = "Draft"
        case forPublicRelease = "ForPublicRelease"
    }
}
