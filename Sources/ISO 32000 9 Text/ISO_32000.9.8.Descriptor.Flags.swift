public import ISO_14496_22
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.`9`.`8`.Descriptor {
    public struct Flags: OptionSet, Sendable, Equatable {
        public let rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}
