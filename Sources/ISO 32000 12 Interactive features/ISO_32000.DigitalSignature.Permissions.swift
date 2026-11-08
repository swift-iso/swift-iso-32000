public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature {
    public struct Permissions: Sendable, Hashable {

        public var docMDP: Int?

        public var ur3: Int?

        public init(
            docMDP: Int? = nil,
            ur3: Int? = nil
        ) {
            self.docMDP = docMDP
            self.ur3 = ur3
        }
    }
}
