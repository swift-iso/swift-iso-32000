// ISO 32000-2:2020, 14.8 Tagged PDF
//
// Sections:
//   14.8.1  General
//   14.8.2  Tagged PDF and page content
//   14.8.3  Tagged PDF and structure tree
//   14.8.4  Standard structure types
//   14.8.5  Standard structure attributes
//   14.8.6  Standard structure namespaces

public import Binary_Primitives
public import Binary_Serializable_Primitives
public import Byte_Primitives
public import ISO_32000_7_Syntax
public import ISO_32000_Shared
public import Standard_Library_Extensions

// MARK: - 14.8 Tagged PDF

extension ISO_32000.`14` {
    /// ISO 32000-2:2020, 14.8 Tagged PDF
    public enum `8` {}
}

// MARK: - 14.8.4 Standard structure types

extension ISO_32000.`14`.`8` {
    /// ISO 32000-2:2020, 14.8.4 Standard structure types
    public enum `4` {}
}

// MARK: - 14.8.4.8 Other structure types

extension ISO_32000.`14`.`8`.`4` {
    /// ISO 32000-2:2020, 14.8.4.8 Other structure types
    public enum `8` {}
}

// MARK: - 14.8.4.8.3 Table structure types

extension ISO_32000.`14`.`8`.`4`.`8` {
    /// ISO 32000-2:2020, 14.8.4.8.3 Table structure types
    public enum `3` {}
}

// MARK: - Table 371 — Table standard structure types

extension ISO_32000.`14`.`8`.`4`.`8`.`3` {
    /// Table 371 — Table
    ///
    /// A two-dimensional logical structure of cells, possibly including a complex substructure.
    /// If a Caption is present, it shall be either the first or last child of the Table structure element.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct Table: Sendable, Hashable {
        /// Summary attribute (Table 384) — table's purpose for accessibility
        ///
        /// For use in non-visual rendering such as speech or braille.
        public var summary: String?

        public init(summary: String? = nil) {
            self.summary = summary
        }
    }

    /// Table 371 — TR
    ///
    /// A row of table header cells (TH) or table data cells (TD) in a table.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct TR: Sendable, Hashable {
        public init() {}
    }

    /// Table 371 — TH
    ///
    /// A table header cell containing content describing one or more rows, columns,
    /// or rows and columns of the table.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct TH: Sendable, Hashable {
        /// Row attributes (Table 384)
        public var row: TH.Row
        /// Col attributes (Table 384)
        public var col: TH.Col
        /// Headers (Table 384) — IDs of associated header cells
        public var headers: [String]
        /// Scope (Table 384) — Row, Column, or Both (nil = implicit)
        public var scope: TH.Scope?
        /// Short (Table 384, PDF 2.0) — short form of header content
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

    /// Table 371 — TD
    ///
    /// A table cell containing content that is part of the table's content.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct TD: Sendable, Hashable {
        /// Row attributes (Table 384)
        public var row: Row
        /// Col attributes (Table 384)
        public var col: Col
        /// Headers (Table 384) — IDs of associated header cells
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

    /// Table 371 — THead
    ///
    /// (Optional) A group of TR structure elements that constitute the header of a table.
    /// The THead structure element is optional insofar as when rows of header cells are
    /// present they may, but are not required to be, so enclosed.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct THead: Sendable, Hashable {
        public init() {}
    }

    /// Table 371 — TBody
    ///
    /// (Optional) A group of TR structure elements that constitute the main body portion of a table.
    /// The TBody structure element is optional insofar as when rows of cells are present
    /// they may, but are not required to be, so enclosed.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
    public struct TBody: Sendable, Hashable {
        public init() {}
    }

    /// Table 371 — TFoot
    ///
    /// (Optional) A group of TR structure elements that constitute the footer of a table.
    /// The TFoot structure element is optional insofar as when rows of cells belonging
    /// to footer row(s) are present they may, but are not required to be, so enclosed.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 371 — Table standard structure types
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

// MARK: - TH Nested Types

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TH {
    /// Table 384 — Scope attribute values
    ///
    /// Row, Column, or Both. When absent, scope is determined implicitly
    /// by the algorithm in 14.8.4.8.3.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 384 — Standard table attributes
    public enum Scope: String, Sendable, Codable, Hashable, CaseIterable {
        case row = "Row"
        case column = "Column"
        case both = "Both"
    }

    /// Row attributes for TH (Table 384)
    public struct Row: Sendable, Hashable {
        /// RowSpan — rows spanned (default: 1)
        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }

    /// Col attributes for TH (Table 384)
    public struct Col: Sendable, Hashable {
        /// ColSpan — columns spanned (default: 1)
        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }
}

// MARK: - TD Nested Types

extension ISO_32000.`14`.`8`.`4`.`8`.`3`.TD {
    /// Row attributes for TD (Table 384)
    public struct Row: Sendable, Hashable {
        /// RowSpan — rows spanned (default: 1)
        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }

    /// Col attributes for TD (Table 384)
    public struct Col: Sendable, Hashable {
        /// ColSpan — columns spanned (default: 1)
        public var span: Int

        public init(span: Int = 1) {
            self.span = span
        }
    }
}

// MARK: - 14.8.4.8.4 Caption structure type

extension ISO_32000.`14`.`8`.`4`.`8` {
    /// ISO 32000-2:2020, 14.8.4.8.4 Caption structure type
    public enum `4` {}
}

extension ISO_32000.`14`.`8`.`4`.`8`.`4` {
    /// Table 372 — Caption
    ///
    /// Content serving as a caption for tables, lists, images, formulas, media objects,
    /// or other types of content.
    ///
    /// For lists and tables a Caption structure element may be used as defined for the
    /// L (list) and Table structure elements. A Caption may be used for a structure element
    /// or several structure elements.
    ///
    /// A structure element is understood to be "captioned" when a Caption structure element
    /// exists as an immediate child of that structure element. The Caption shall be the first
    /// or the last structure element inside its parent structure element.
    /// The number of captions cannot exceed 1.
    ///
    /// ## Reference
    ///
    /// ISO 32000-2:2020, Table 372 — Standard structure type Caption
    public struct Caption: Sendable, Hashable {
        public init() {}
    }
}

// MARK: - Binary.Serializable Conformance

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
    /// The PDF Name for this scope value
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
