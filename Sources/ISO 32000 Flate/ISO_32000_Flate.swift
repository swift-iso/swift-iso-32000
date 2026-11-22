public import ISO_32000
public import RFC_1950

extension ISO.`32000`.StreamCompression {

    public static let flate = ISO.`32000`.StreamCompression { input, output in
        IETF.RFC.`1950`.compress(input, into: &output)
    }

    public static func flate(level: IETF.RFC.`1951`.Level) -> ISO.`32000`.StreamCompression {
        ISO.`32000`.StreamCompression { input, output in
            IETF.RFC.`1950`.compress(input, into: &output, level: level)
        }
    }
}

extension ISO.`32000`.Writer {

    public static func flate(level: IETF.RFC.`1951`.Level = .balanced) -> ISO.`32000`.Writer {
        ISO.`32000`.Writer(compression: .flate(level: level))
    }
}
