public import Geometry
public import ISO_32000_7_Syntax
public import ISO_32000_8_Graphics
public import ISO_32000_Shared
public import RFC_3986
public import RFC_5646


extension ISO_32000.`12`.`5` {
    public struct Markup: Sendable, Hashable {

        public var title: String?

        public var richContents: String?

        public var creationDate: String?

        public var inReplyTo: String?

        public var subject: String?

        public var replyType: ReplyType?

        public var intent: String?

        public init(
            title: String? = nil,
            richContents: String? = nil,
            creationDate: String? = nil,
            inReplyTo: String? = nil,
            subject: String? = nil,
            replyType: ReplyType? = nil,
            intent: String? = nil
        ) {
            self.title = title
            self.richContents = richContents
            self.creationDate = creationDate
            self.inReplyTo = inReplyTo
            self.subject = subject
            self.replyType = replyType
            self.intent = intent
        }
    }
}
