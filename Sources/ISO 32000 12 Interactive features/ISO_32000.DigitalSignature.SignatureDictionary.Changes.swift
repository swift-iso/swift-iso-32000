public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureDictionary {
    public struct Changes: Sendable, Hashable {
        public var pagesAltered: Int
        public var fieldsAltered: Int
        public var fieldsFilled: Int

        public init(pagesAltered: Int, fieldsAltered: Int, fieldsFilled: Int) {
            self.pagesAltered = pagesAltered
            self.fieldsAltered = fieldsAltered
            self.fieldsFilled = fieldsFilled
        }
    }
}
