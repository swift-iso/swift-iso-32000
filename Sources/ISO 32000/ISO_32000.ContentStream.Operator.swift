import Binary_Primitives
import Binary_Serializable_Primitives
public import Byte_Primitives
import Format_Primitives
import Geometry_Primitives
import ISO_32000_7_Syntax

extension ISO_32000.ContentStream {

    package enum Operator: Sendable, Equatable {

        case saveState

        case restoreState

        case transform(
            a: Scale<1, Double>,
            b: Scale<1, Double>,
            c: Scale<1, Double>,
            d: Scale<1, Double>,
            e: ISO_32000.UserSpace.Dx,
            f: ISO_32000.UserSpace.Dy
        )

        case setStrokeGray(Double)

        case setFillGray(Double)

        case setStrokeRGB(r: Double, g: Double, b: Double)

        case setFillRGB(r: Double, g: Double, b: Double)

        case setStrokeCMYK(c: Double, m: Double, y: Double, k: Double)

        case setFillCMYK(c: Double, m: Double, y: Double, k: Double)

        case moveTo(x: ISO_32000.UserSpace.X, y: ISO_32000.UserSpace.Y)

        case lineTo(x: ISO_32000.UserSpace.X, y: ISO_32000.UserSpace.Y)

        case curveTo(
            x1: ISO_32000.UserSpace.X,
            y1: ISO_32000.UserSpace.Y,
            x2: ISO_32000.UserSpace.X,
            y2: ISO_32000.UserSpace.Y,
            x3: ISO_32000.UserSpace.X,
            y3: ISO_32000.UserSpace.Y
        )

        case rectangle(
            x: ISO_32000.UserSpace.X,
            y: ISO_32000.UserSpace.Y,
            width: ISO_32000.UserSpace.Width,
            height: ISO_32000.UserSpace.Height
        )

        case closePath

        case stroke

        case closeAndStroke

        case fill

        case fillEvenOdd

        case fillAndStroke

        case endPath

        case clip

        case clipEvenOdd

        case beginText

        case endText

        case setFont(name: ISO_32000.COS.Name, size: ISO_32000.UserSpace.Size<1>)

        case setTextLeading(ISO_32000.UserSpace.Height)

        case setCharacterSpacing(ISO_32000.UserSpace.Width)

        case setWordSpacing(ISO_32000.UserSpace.Width)

        case setHorizontalScaling(Scale<1, Double>)

        case setTextRise(ISO_32000.UserSpace.Y)

        case moveTextPosition(tx: ISO_32000.UserSpace.Dx, ty: ISO_32000.UserSpace.Dy)

        case moveTextPositionWithLeading(tx: ISO_32000.UserSpace.Dx, ty: ISO_32000.UserSpace.Dy)

        case setTextMatrix(
            a: Scale<1, Double>,
            b: Scale<1, Double>,
            c: Scale<1, Double>,
            d: Scale<1, Double>,
            e: ISO_32000.UserSpace.Dx,
            f: ISO_32000.UserSpace.Dy
        )

        case nextLine

        case showText([Byte])

        case setLineWidth(ISO_32000.UserSpace.Width)

        case setLineCap(LineCap)

        case setLineJoin(LineJoin)

        case setMiterLimit(ISO_32000.UserSpace.Width)

        case setDashPattern(array: [ISO_32000.UserSpace.Width], phase: ISO_32000.UserSpace.Width)

        case beginMarkedContent(tag: ISO_32000.COS.Name)

        case beginMarkedContentWithProperties(
            tag: ISO_32000.COS.Name,
            properties: ISO_32000.COS.Dictionary
        )

        case endMarkedContent

        case paintXObject(name: ISO_32000.COS.Name)
    }
}

extension ISO_32000.ContentStream.Operator {

    package func serialize<Buffer: RangeReplaceableCollection>(
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        switch self {

        case .saveState:
            buffer.append(.ascii.q)

        case .restoreState:
            buffer.append(.ascii.Q)

        case .transform(let a, let b, let c, let d, let e, let f):
            a.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            b.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            c.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            d.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            e.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            f.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.c, .ascii.m])

        case .setStrokeGray(let gray):
            gray.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.G])

        case .setFillGray(let gray):
            gray.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.g])

        case .setStrokeRGB(let r, let g, let b):
            r.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            g.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            b.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.R, .ascii.G])

        case .setFillRGB(let r, let g, let b):
            r.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            g.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            b.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.r, .ascii.g])

        case .setStrokeCMYK(let c, let m, let y, let k):
            c.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            m.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            k.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.K])

        case .setFillCMYK(let c, let m, let y, let k):
            c.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            m.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            k.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.k])

        case .moveTo(let x, let y):
            x.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.m])

        case .lineTo(let x, let y):
            x.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.l])

        case .curveTo(let x1, let y1, let x2, let y2, let x3, let y3):
            x1.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y1.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            x2.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y2.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            x3.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y3.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.c])

        case .rectangle(let x, let y, let width, let height):
            x.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            y.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            width.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            height.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.r, .ascii.e])

        case .closePath:
            buffer.append(.ascii.h)

        case .stroke:
            buffer.append(.ascii.S)

        case .closeAndStroke:
            buffer.append(.ascii.s)

        case .fill:
            buffer.append(.ascii.f)

        case .fillEvenOdd:
            buffer.append(contentsOf: [.ascii.f, .ascii.asterisk])

        case .fillAndStroke:
            buffer.append(.ascii.B)

        case .endPath:
            buffer.append(.ascii.n)

        case .clip:
            buffer.append(.ascii.W)

        case .clipEvenOdd:
            buffer.append(contentsOf: [.ascii.W, .ascii.asterisk])

        case .beginText:
            buffer.append(contentsOf: [.ascii.B, .ascii.T])

        case .endText:
            buffer.append(contentsOf: [.ascii.E, .ascii.T])

        case .setFont(let name, let size):
            buffer.append(.ascii.forwardSlash)
            buffer.append(contentsOf: name.rawValue.utf8)
            buffer.append(.ascii.space)
            size.length.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.f])

        case .setTextLeading(let leading):
            leading.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.L])

        case .setCharacterSpacing(let spacing):
            spacing.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.c])

        case .setWordSpacing(let spacing):
            spacing.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.w])

        case .setHorizontalScaling(let scale):
            scale.value.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.z])

        case .setTextRise(let rise):
            rise.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.s])

        case .moveTextPosition(let tx, let ty):
            tx.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            ty.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.d])

        case .moveTextPositionWithLeading(let tx, let ty):
            tx.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            ty.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.D])

        case .setTextMatrix(let a, let b, let c, let d, let e, let f):
            a.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            b.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            c.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            d.value.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            e.underlying.pdf.serialize(into: &buffer)
            buffer.append(.ascii.space)
            f.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.m])

        case .nextLine:
            buffer.append(contentsOf: [.ascii.T, .ascii.asterisk])

        case .showText(let bytes):

            ISO_32000.`7`.`3`.Table.`3`.serializeLiteralString(bytes, into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.T, .ascii.j])

        case .setLineWidth(let width):
            width.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.w])

        case .setLineCap(let cap):
            ASCII.Decimal.serialize(cap.rawValue, into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.J])

        case .setLineJoin(let join):
            ASCII.Decimal.serialize(join.rawValue, into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.j])

        case .setMiterLimit(let limit):
            limit.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.M])

        case .setDashPattern(let array, let phase):
            buffer.append(.ascii.leftSquareBracket)
            for (index, value) in array.enumerated() {
                if index > 0 { buffer.append(.ascii.space) }
                value.underlying.pdf.serialize(into: &buffer)
            }
            buffer.append(contentsOf: [.ascii.rightSquareBracket, .ascii.space])
            phase.underlying.pdf.serialize(into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.d])

        case .beginMarkedContent(let tag):
            buffer.append(.ascii.forwardSlash)
            buffer.append(contentsOf: tag.rawValue.utf8)
            buffer.append(contentsOf: [.ascii.space, .ascii.B, .ascii.M, .ascii.C])

        case .beginMarkedContentWithProperties(let tag, let properties):
            buffer.append(.ascii.forwardSlash)
            buffer.append(contentsOf: tag.rawValue.utf8)
            buffer.append(.ascii.space)
            ISO_32000.COS.Dictionary.serialize(properties, into: &buffer)
            buffer.append(contentsOf: [.ascii.space, .ascii.B, .ascii.D, .ascii.C])

        case .endMarkedContent:
            buffer.append(contentsOf: [.ascii.E, .ascii.M, .ascii.C])

        case .paintXObject(let name):
            buffer.append(.ascii.forwardSlash)
            buffer.append(contentsOf: name.rawValue.utf8)
            buffer.append(contentsOf: [.ascii.space, .ascii.D, .ascii.o])
        }
    }
}
