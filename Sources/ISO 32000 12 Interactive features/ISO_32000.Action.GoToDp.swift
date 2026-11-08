public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct GoToDp: Sendable, Hashable {

        public var dpart: Int

        public init(dpart: Int) {
            self.dpart = dpart
        }
    }
}
