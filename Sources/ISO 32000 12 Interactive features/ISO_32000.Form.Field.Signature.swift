public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form.Field {
    public struct Signature: Sendable, Hashable {

        public var signatureValue: Int?

        public var seedValue: SeedValue?

        public var lock: Lock?

        public init(
            signatureValue: Int? = nil,
            seedValue: SeedValue? = nil,
            lock: Lock? = nil
        ) {
            self.signatureValue = signatureValue
            self.seedValue = seedValue
            self.lock = lock
        }
    }
}
