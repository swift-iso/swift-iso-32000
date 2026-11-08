public import Byte
public import ISO_32000_Shared


extension ISO_32000.`9`.`4` {
    public enum TJElement: Sendable {

        case string([Byte])

        case adjustment(Double)
    }
}
