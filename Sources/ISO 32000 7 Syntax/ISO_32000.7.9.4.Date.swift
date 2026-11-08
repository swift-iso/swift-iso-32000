public import ISO_32000_Shared


extension ISO_32000.`7`.`9`.`4` {
    public struct Date: Sendable, Hashable {
        public var year: Int
        public var month: Int
        public var day: Int
        public var hour: Int
        public var minute: Int
        public var second: Int

        public init(
            year: Int,
            month: Int,
            day: Int,
            hour: Int = 0,
            minute: Int = 0,
            second: Int = 0
        ) {
            self.year = year
            self.month = month
            self.day = day
            self.hour = hour
            self.minute = minute
            self.second = second
        }
    }
}
