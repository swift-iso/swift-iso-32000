public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public struct GoTo: Sendable {

        public var destination: ISO_32000.Destination

        public var structureDestination: [String]?

        public init(destination: ISO_32000.Destination) {
            self.destination = destination
            self.structureDestination = nil
        }
    }
}
