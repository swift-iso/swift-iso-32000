public import Byte
public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Ownership


extension ISO_32000.`9`.`6`.Embedded {
    public enum SubsettingError: Swift::Error, Sendable {

        case subset(ISO_14496_22.FontSubsetter.SubsetError)

        case parsing(ISO_14496_22.FontFile.ParsingError)
    }
}
