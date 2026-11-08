public import Geometry
public import IEC_61966
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.`12`.`3` {
    public struct Collection: Sendable {

        public var view: CollectionView

        public var initialDocument: String?

        public var sort: CollectionSort?

        public init(
            view: CollectionView = .details,
            initialDocument: String? = nil,
            sort: CollectionSort? = nil
        ) {
            self.view = view
            self.initialDocument = initialDocument
            self.sort = sort
        }
    }
}
