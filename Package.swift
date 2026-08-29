// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-iso-32000",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "ISO 32000", targets: ["ISO 32000"]),
        .library(name: "ISO 32000 Flate", targets: ["ISO 32000 Flate"]),
        .library(name: "ISO 32000 Shared", targets: ["ISO 32000 Shared"]),
        .library(
            name: "ISO 32000 3 Terms and definitions",
            targets: ["ISO 32000 3 Terms and definitions"]
        ),
        .library(name: "ISO 32000 7 Syntax", targets: ["ISO 32000 7 Syntax"]),
        .library(name: "ISO 32000 8 Graphics", targets: ["ISO 32000 8 Graphics"]),
        .library(name: "ISO 32000 9 Text", targets: ["ISO 32000 9 Text"]),
        .library(name: "ISO 32000 10 Rendering", targets: ["ISO 32000 10 Rendering"]),
        .library(name: "ISO 32000 11 Transparency", targets: ["ISO 32000 11 Transparency"]),
        .library(
            name: "ISO 32000 12 Interactive features",
            targets: ["ISO 32000 12 Interactive features"]
        ),
        .library(
            name: "ISO 32000 13 Multimedia features",
            targets: ["ISO 32000 13 Multimedia features"]
        ),
        .library(
            name: "ISO 32000 14 Document interchange",
            targets: ["ISO 32000 14 Document interchange"]
        ),
        .library(name: "ISO 32000 Annex D", targets: ["ISO 32000 Annex D"]),
    ],
    dependencies: [

        .package(
            url: "https://github.com/swift-molecules/swift-geometry.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-format.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-dimension.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-numeric.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-binary.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-binary-serializer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-standard-library-extensions.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-witness.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership.git",
            branch: "main"
        ),

        .package(url: "https://github.com/swift-iso/swift-iso-9899.git", branch: "main"),
        .package(url: "https://github.com/swift-ieee/swift-ieee-754.git", branch: "main"),
        .package(
            url: "https://github.com/swift-molecules/swift-ascii.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ietf/swift-rfc-1950.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4648.git", branch: "main"),
        .package(url: "https://github.com/swift-iec/swift-iec-61966.git", branch: "main"),
        .package(url: "https://github.com/swift-w3c/swift-w3c-png.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-14496-22.git", branch: "main"),

    ],
    targets: [

        .target(
            name: "ISO 32000 Shared",
            dependencies: [
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Numeric", package: "swift-numeric"),
            ]
        ),

        .target(
            name: "ISO 32000 3 Terms and definitions",
            dependencies: [
                "ISO 32000 Shared",
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "ISO 32000 7 Syntax",
            dependencies: [
                "ISO 32000 Shared",
                "ISO 32000 3 Terms and definitions",
                "ISO 32000 Annex D",
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "Format", package: "swift-format"),
                .product(name: "Binary", package: "swift-binary"),
                .product(
                    name: "Binary Standard Library Integration",
                    package: "swift-binary"
                ),
                .product(name: "IEEE 754", package: "swift-ieee-754"),
            ]
        ),
        .target(
            name: "ISO 32000 8 Graphics",
            dependencies: [
                "ISO 32000 Shared",
                "ISO 32000 7 Syntax",
                .product(
                    name: "Binary Standard Library Integration",
                    package: "swift-binary"
                ),
                .product(name: "IEC 61966", package: "swift-iec-61966"),
                .product(name: "Dimension", package: "swift-dimension"),
            ]
        ),
        .target(
            name: "ISO 32000 9 Text",
            dependencies: [
                "ISO 32000 Shared",
                "ISO 32000 7 Syntax",
                "ISO 32000 8 Graphics",
                "ISO 32000 Annex D",
                .product(name: "ISO 14496-22", package: "swift-iso-14496-22"),
                .product(name: "Ownership", package: "swift-ownership"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "ISO 32000 10 Rendering",
            dependencies: ["ISO 32000 Shared", "ISO 32000 7 Syntax", "ISO 32000 8 Graphics"]
        ),
        .target(
            name: "ISO 32000 11 Transparency",
            dependencies: ["ISO 32000 Shared", "ISO 32000 7 Syntax", "ISO 32000 8 Graphics"]
        ),
        .target(
            name: "ISO 32000 12 Interactive features",
            dependencies: ["ISO 32000 Shared", "ISO 32000 7 Syntax", "ISO 32000 8 Graphics"]
        ),
        .target(
            name: "ISO 32000 13 Multimedia features",
            dependencies: ["ISO 32000 Shared", "ISO 32000 7 Syntax"]
        ),
        .target(
            name: "ISO 32000 14 Document interchange",
            dependencies: [
                "ISO 32000 Shared",
                "ISO 32000 7 Syntax",
                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
                .product(name: "Binary", package: "swift-binary"),
                .product(
                    name: "Binary Serializable",
                    package: "swift-binary-serializer"
                ),
            ]
        ),
        .target(
            name: "ISO 32000 Annex D",
            dependencies: [
                "ISO 32000 Shared",
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),

        .target(
            name: "ISO 32000",
            dependencies: [
                "ISO 32000 3 Terms and definitions",
                "ISO 32000 7 Syntax",
                "ISO 32000 8 Graphics",
                "ISO 32000 9 Text",
                "ISO 32000 10 Rendering",
                "ISO 32000 11 Transparency",
                "ISO 32000 12 Interactive features",
                "ISO 32000 13 Multimedia features",
                "ISO 32000 14 Document interchange",
                "ISO 32000 Annex D",
                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Format", package: "swift-format"),
                .product(name: "Binary", package: "swift-binary"),
                .product(
                    name: "Binary Standard Library Integration",
                    package: "swift-binary"
                ),
                .product(
                    name: "Binary Serializable",
                    package: "swift-binary-serializer"
                ),
                .product(
                    name: "Byte Standard Library Integration",
                    package: "swift-byte"
                ),
                .product(name: "ISO 9899", package: "swift-iso-9899"),
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "RFC 4648", package: "swift-rfc-4648"),
                .product(name: "Witness", package: "swift-witness"),
            ]
        ),
        .target(
            name: "ISO 32000 Flate",
            dependencies: [
                "ISO 32000",
                "ISO 32000 Shared",
                .product(name: "RFC 1950", package: "swift-rfc-1950"),
                .product(name: "W3C PNG", package: "swift-w3c-png"),
            ]
        ),
        .testTarget(
            name: "ISO 32000 Annex D Tests",
            dependencies: [
                "ISO 32000",
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .testTarget(
            name: "ISO 32000 Tests",
            dependencies: [
                "ISO 32000",
                "ISO 32000 9 Text",
                "ISO 32000 Flate",
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
}

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
