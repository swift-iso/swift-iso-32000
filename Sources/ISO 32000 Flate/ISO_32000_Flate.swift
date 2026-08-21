public import ISO_32000
public import RFC_1950

extension ISO_32000.StreamCompression {

    public static let flate = ISO_32000.StreamCompression { input, output in
        RFC_1950.compress(input, into: &output)
    }

    public static func flate(level: RFC_1951.Level) -> ISO_32000.StreamCompression {
        ISO_32000.StreamCompression { input, output in
            RFC_1950.compress(input, into: &output, level: level)
        }
    }
}

extension ISO_32000.Writer {

    public static func flate(level: RFC_1951.Level = .balanced) -> ISO_32000.Writer {
        ISO_32000.Writer(compression: .flate(level: level))
    }
}
