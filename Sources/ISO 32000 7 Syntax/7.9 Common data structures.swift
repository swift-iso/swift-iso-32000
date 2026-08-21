public import ISO_32000_Shared

extension ISO_32000.`7` {

    public enum `9` {}
}

extension ISO_32000.`7`.`9` {

    public enum `4` {}
}

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

extension ISO_32000.`7`.`9`.`4`.Date: CustomStringConvertible {

    public var description: Swift.String {
        func pad(_ value: Int, width: Int) -> Swift.String {
            var s = Swift.String(value)
            while s.count < width {
                s = "0" + s
            }
            return s
        }
        return
            "D:\(pad(year, width: 4))\(pad(month, width: 2))\(pad(day, width: 2))\(pad(hour, width: 2))\(pad(minute, width: 2))\(pad(second, width: 2))"
    }
}

extension ISO_32000.`7`.`9` {

    public enum `5` {}
}
