public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Form {
    public struct AcroForm: Sendable, Hashable {

        public var fields: [Int]

        public var needAppearances: Bool

        public var sigFlags: SigOptions

        public var calculationOrder: [Int]?

        public var defaultResources: Int?

        public var defaultAppearance: String?

        public var defaultQuadding: Quadding?

        public init(
            fields: [Int],
            needAppearances: Bool = false,
            sigFlags: SigOptions = [],
            calculationOrder: [Int]? = nil,
            defaultResources: Int? = nil,
            defaultAppearance: String? = nil,
            defaultQuadding: Quadding? = nil
        ) {
            self.fields = fields
            self.needAppearances = needAppearances
            self.sigFlags = sigFlags
            self.calculationOrder = calculationOrder
            self.defaultResources = defaultResources
            self.defaultAppearance = defaultAppearance
            self.defaultQuadding = defaultQuadding
        }
    }
}
