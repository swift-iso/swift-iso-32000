public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature {
    public struct SignatureReference: Sendable, Hashable {

        public var transformMethod: TransformMethod

        public var transformParams: TransformParams?

        public var data: Int?

        public var digestMethod: DigestMethod

        public init(
            transformMethod: TransformMethod,
            transformParams: TransformParams? = nil,
            data: Int? = nil,
            digestMethod: DigestMethod
        ) {
            self.transformMethod = transformMethod
            self.transformParams = transformParams
            self.data = data
            self.digestMethod = digestMethod
        }
    }
}
