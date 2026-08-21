import Foundation
import Testing

@testable import ISO_32000

extension ISO_32000 {
    @Suite struct Tests {
        @Suite struct `Edge Case` {}
    }
}

extension ISO_32000.Tests.`Edge Case` {
    @Test
    func `no verbatim ISO purchase watermark remains anywhere in package sources`() throws {
        let sourcesRoot = try Self.packageSourcesRoot()
        let offending = try Self.swiftFiles(
            under: sourcesRoot,
            containing: "Sold by the PDF Association"
        )
        #expect(offending.isEmpty, "Verbatim ISO purchase watermark found in: \(offending)")
    }

    @Test
    func `no verbatim ISO copyright line remains anywhere in package sources`() throws {
        let sourcesRoot = try Self.packageSourcesRoot()
        let offending = try Self.swiftFiles(under: sourcesRoot, containing: "© ISO 2020")
        #expect(offending.isEmpty, "Verbatim ISO copyright line found in: \(offending)")
    }

    private static func packageSourcesRoot(
        testFile: String = #filePath
    ) throws -> URL {
        URL(fileURLWithPath: testFile)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Sources")
    }

    private static func swiftFiles(under root: URL, containing needle: String) throws -> [String] {
        let fm = FileManager.default
        guard
            let enumerator = fm.enumerator(
                at: root,
                includingPropertiesForKeys: [.isRegularFileKey],
                options: [.skipsHiddenFiles]
            )
        else {
            Issue.record("Could not enumerate \(root.path)")
            return []
        }

        var offending: [String] = []
        for case let fileURL as URL in enumerator {
            guard fileURL.pathExtension == "swift" else { continue }
            guard let contents = try? String(contentsOf: fileURL, encoding: .utf8) else { continue }
            if contents.contains(needle) {
                offending.append(fileURL.path)
            }
        }
        return offending
    }
}
