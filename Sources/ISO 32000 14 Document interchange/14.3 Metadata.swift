public import ISO_32000_7_Syntax
public import ISO_32000_Shared

extension ISO_32000.`14` {

    public enum `3` {}
}

extension ISO_32000.`14`.`3` {

    public enum `3` {}
}

extension ISO_32000.`14`.`3`.`3` {

    public struct Info: Sendable {

        public var title: String?

        public var author: String?

        public var subject: String?

        public var keywords: String?

        public var creator: String?

        public var producer: String?

        public var creationDate: ISO_32000.`7`.`9`.`4`.Date?

        public var modificationDate: ISO_32000.`7`.`9`.`4`.Date?

        public init(
            title: String? = nil,
            author: String? = nil,
            subject: String? = nil,
            keywords: String? = nil,
            creator: String? = nil,
            producer: String? = nil,
            creationDate: ISO_32000.`7`.`9`.`4`.Date? = nil,
            modificationDate: ISO_32000.`7`.`9`.`4`.Date? = nil
        ) {
            self.title = title
            self.author = author
            self.subject = subject
            self.keywords = keywords
            self.creator = creator
            self.producer = producer
            self.creationDate = creationDate
            self.modificationDate = modificationDate
        }
    }
}
