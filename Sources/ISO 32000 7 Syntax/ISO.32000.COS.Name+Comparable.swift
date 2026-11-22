public import ISO_32000_Shared

extension ISO.`32000`.COS.Name: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
