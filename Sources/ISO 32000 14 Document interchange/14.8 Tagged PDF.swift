public import Binary_Primitives
public import Binary_Serializable_Primitives
import Byte_Primitives
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
import Standard_Library_Extensions

extension ISO_32000.`14` {

    public enum `8` {}
}

extension ISO_32000.`14`.`8` {

    public enum `4` {}
}

extension ISO_32000.`14`.`8`.`4` {

    public enum `8` {}
}

extension ISO_32000.`14`.`8`.`4`.`8` {

    public enum `3` {}
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3` {

    public struct Table: Sendable, Hashable {

        public var summary: String?

        public init(summary: String? = nil) {
            self.summary = summary
        }
    }

    public struct TR: Sendable, Hashable {
        public init() {}
    }

    public struct TH: Sendable, Hashable {

        public var row: TH.Row

        public var col: TH.Col

        public var headers: [String]

        public var scope: TH.Scope?

        public var short: String?

        public init(
            row: TH.Row = Row(),
            col: TH.Col = Col(),
            headers: [String] = [],
            scope: TH.Scope? = nil,
            short: String? = nil
        ) {
            self.row = row
            self.col = col
            self.headers = headers
            self.scope = scope
            self.short = short
        }
    }

    public struct TD: Sendable, Hashable {

        public var row: Row

        public var col: Col

        public var headers: [String]

        public init(
            row: Row = Row(),
            col: Col = Col(),
            headers: [String] = []
        ) {
            self.row = row
            self.col = col
            self.headers = headers
        }
    }

    public struct THead: Sendable, Hashable {
        public init() {}
    }

    public struct TBody: Sendable, Hashable {
        public init() {}
    }

    public struct TFoot: Sendable, Hashable {
        public init() {}
    }
}

extension ISO_32000 {
    public typealias Table = ISO_32000.`14`.`8`.`4`.`8`.`3`.Table
    public typealias TR = ISO_32000.`14`.`8`.`4`.`8`.`3`.TR
    public typealias TH = ISO_32000.`14`.`8`.`4`.`8`.`3`.TH
    public typealias TD = ISO_32000.`14`.`8`.`4`.`8`.`3`.TD
    public typealias THead = ISO_32000.`14`.`8`.`4`.`8`.`3`.THead
    public typealias TBody = ISO_32000.`14`.`8`.`4`.`8`.`3`.TBody
    public typealias TFoot = ISO_32000.`14`.`8`.`4`.`8`.`3`.TFoot
}

extension ISO_32000.Table {
    public typealias Row = ISO_32000.TR
    public typealias Header = ISO_32000.THead
    public typealias Body = ISO_32000.TBody
    public typealias Footer = ISO_32000.TFoot
}

extension ISO_32000.Table.Row {
    public typealias Cell = ISO_32000.TD
}

extension ISO_32000.Table.Header {
    public typealias Cell = ISO_32000.TH
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH {

    public enum Scope: String, Sendable, Codable, Hashable, CaseIterable {
        case row = "Row"
        case column = "Column"
        case both = "Both"
    }

    public struct Row: Sendable, Hashable {

        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }

    public struct Col: Sendable, Hashable {

        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TD {

    public struct Row: Sendable, Hashable {

        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }

    public struct Col: Sendable, Hashable {

        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }
}

extension ISO_32000.`14`.`8`.`4`.`8` {

    public enum `4` {}
}

extension ISO_32000.`14`.`8`.`4`.`8`.`4` {

    public struct Caption: Sendable, Hashable {
        public init() {}
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.Table: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ table: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        var dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.table)
        ]
        if let summary = table.summary {
            dict[.summary] = .string(ISO_32000.`7`.`3`.COS.StringValue(summary))
        }
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TR: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ tr: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        let dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.tr)
        ]
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ th: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        var dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.th)
        ]
        if th.row.span != 1 {
            dict[.rowSpan] = .integer(Int64(th.row.span))
        }
        if th.col.span != 1 {
            dict[.colSpan] = .integer(Int64(th.col.span))
        }
        if !th.headers.isEmpty {
            dict[.headers] = .array(
                th.headers.map { .string(ISO_32000.`7`.`3`.COS.StringValue($0)) }
            )
        }
        if let scope = th.scope {
            dict[.scope] = .name(scope.name)
        }
        if let short = th.short {
            dict[.short] = .string(ISO_32000.`7`.`3`.COS.StringValue(short))
        }
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH.Scope {

    public var name: ISO_32000.`7`.`3`.`5`.Name {
        switch self {
        case .row: return .row
        case .column: return .column
        case .both: return .both
        }
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TD: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ td: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        var dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.td)
        ]
        if td.row.span != 1 {
            dict[.rowSpan] = .integer(Int64(td.row.span))
        }
        if td.col.span != 1 {
            dict[.colSpan] = .integer(Int64(td.col.span))
        }
        if !td.headers.isEmpty {
            dict[.headers] = .array(
                td.headers.map { .string(ISO_32000.`7`.`3`.COS.StringValue($0)) }
            )
        }
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.THead: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ thead: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        let dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.thead)
        ]
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TBody: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ tbody: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        let dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.tbody)
        ]
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TFoot: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ tfoot: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        let dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.tfoot)
        ]
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}

extension ISO_32000.`14`.`8`.`4`.`8`.`4`.Caption: Binary.Serializable {
    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ caption: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        let dict: ISO_32000.`7`.`3`.COS.Dictionary = [
            .s: .name(.caption)
        ]
        ISO_32000.`7`.`3`.COS.Dictionary.serialize(dict, into: &buffer)
    }
}
