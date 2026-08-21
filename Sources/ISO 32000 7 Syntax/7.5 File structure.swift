public import Byte_Primitives
public import ISO_32000_Shared

extension ISO_32000.`7` {

    public enum `5` {}
}

extension ISO_32000.`7`.`5` {

    public enum `2` {}
}

extension ISO_32000.`7`.`5`.`2` {

    public enum Version: String, Sendable, Hashable, Codable, CaseIterable {

        case v1_4 = "1.4"

        case v1_5 = "1.5"

        case v1_6 = "1.6"

        case v1_7 = "1.7"

        case v2_0 = "2.0"
    }
}

extension ISO_32000.`7`.`5`.`2`.Version {

    public static let `default`: ISO_32000.`7`.`5`.`2`.Version = .v1_7

    public var header: String {
        "%PDF-\(rawValue)"
    }

    public var headerBytes: [Byte] {
        header.utf8.map(Byte.init)
    }
}
