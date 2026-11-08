public import Byte
public import ISO_32000_Shared

extension ISO_32000.`7` {

    public enum `5` {}
}

extension ISO_32000.`7`.`5` {
}

extension ISO_32000.`7`.`5`.`2` {
}

extension ISO_32000.`7`.`5`.`2`.Version {

    public static let `default`: ISO_32000.`7`.`5`.`2`.Version = .v1_7

    public var header: String {
        "%PDF-\(rawValue)"
    }

    public var headerBytes: [Byte] {
        header.utf8.map(Byte.init(bitPattern:))
    }
}
