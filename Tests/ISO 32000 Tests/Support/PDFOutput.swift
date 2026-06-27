// PDFOutput.swift

import Foundation
import Byte_Primitives

enum PDFOutput {
    static let directory = "/tmp/pdf-tests"

    static func write(_ bytes: [Byte], name: String) throws -> String {
        let fm = FileManager.default
        try fm.createDirectory(atPath: directory, withIntermediateDirectories: true)
        let path = "\(directory)/\(name).pdf"
        try Data(bytes.map(\.underlying)).write(to: URL(fileURLWithPath: path))
        return path
    }
}
