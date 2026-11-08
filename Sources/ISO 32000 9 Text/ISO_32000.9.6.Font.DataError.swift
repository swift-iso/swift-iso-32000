public import Byte
public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Ownership


extension ISO_32000.`9`.`6`.Font {
    public enum DataError: Swift::Error, Sendable {

        case parsing(ISO_14496_22.FontFile.ParsingError)

        case name(ISO_32000.`7`.`3`.COS.Name.Error)
    }
}
