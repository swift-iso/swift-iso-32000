public import Geometry
import ISO_32000_8_Graphics
public import ISO_32000_Shared


extension ISO_32000.Article {
    public struct Info: Sendable, Equatable, Hashable, Codable {

        public var title: String?

        public var author: String?

        public var subject: String?

        public var keywords: String?

        public init(
            title: String? = nil,
            author: String? = nil,
            subject: String? = nil,
            keywords: String? = nil
        ) {
            self.title = title
            self.author = author
            self.subject = subject
            self.keywords = keywords
        }
    }
}
