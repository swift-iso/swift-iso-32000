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
            url: "https://github.com/swift-atoms/swift-geometry.git",
            branch: "main", traits: ["Affine"]),
        .package(
            url: "https://github.com/swift-atoms/swift-formatter.git",
            branch: "main", traits: ["Conversions"]),
        .package(
            url: "https://github.com/swift-atoms/swift-spatial.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-quantizer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-binary.git",
            branch: "main", traits: ["Serializer"]),
        .package(
            url: "https://github.com/swift-atoms/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-standard-library-extensions.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-witness.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ownership.git",
            branch: "main"
        ),

        .package(url: "https://github.com/swift-iso/swift-iso-9899.git", branch: "main"),
        .package(url: "https://github.com/swift-ieee/swift-ieee-754.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-ascii.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ietf/swift-rfc-1950.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4648.git", branch: "main"),
        .package(url: "https://github.com/swift-iec/swift-iec-61966.git", branch: "main"),
        .package(url: "https://github.com/swift-w3c/swift-w3c-png.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-14496-22.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-angle.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-linear.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-scale.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-trigonometry.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-interval.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-numeric.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-tagged.git", branch: "main"),
    ],
    targets: [

        .target(
            name: "ISO 32000 Shared",
            dependencies: [
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Quantizer", package: "swift-quantizer"),
                .product(name: "Linear", package: "swift-linear"),
            ]
        ),

        .target(
            name: "ISO 32000 3 Terms and definitions",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "ISO 32000 7 Syntax",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .target(name: "ISO 32000 3 Terms and definitions"),
                .target(name: "ISO 32000 Annex D"),
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "Formatter", package: "swift-formatter"),
                .product(name: "Binary", package: "swift-binary"),
                .product(
                    name: "Binary",
                    package: "swift-binary"
                ),
                .product(name: "IEEE 754", package: "swift-ieee-754"),
                .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions"),
            ]
        ),
        .target(
            name: "ISO 32000 8 Graphics",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .target(name: "ISO 32000 7 Syntax"),
                .product(
                    name: "Binary",
                    package: "swift-binary"
                ),
                .product(name: "IEC 61966", package: "swift-iec-61966"),
                .product(name: "Spatial", package: "swift-spatial"),
                .product(name: "Linear", package: "swift-linear"),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Angle", package: "swift-angle"),
                .product(name: "Trigonometry", package: "swift-trigonometry"),
                .product(name: "Tagged", package: "swift-tagged"),                .product(name: "Interval", package: "swift-interval"),
                .product(name: "Numeric", package: "swift-numeric"),
            ]
        ),
        .target(
            name: "ISO 32000 9 Text",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .target(name: "ISO 32000 7 Syntax"),
                .target(name: "ISO 32000 8 Graphics"),
                .target(name: "ISO 32000 Annex D"),
                .product(name: "ISO 14496-22", package: "swift-iso-14496-22"),
                .product(name: "Ownership", package: "swift-ownership"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "ISO 32000 10 Rendering",
            dependencies: [.target(name: "ISO 32000 Shared"), .target(name: "ISO 32000 7 Syntax"), .target(name: "ISO 32000 8 Graphics")]
        ),
        .target(
            name: "ISO 32000 11 Transparency",
            dependencies: [.target(name: "ISO 32000 Shared"), .target(name: "ISO 32000 7 Syntax"), .target(name: "ISO 32000 8 Graphics")]
        ),
        .target(
            name: "ISO 32000 12 Interactive features",
            dependencies: [.target(name: "ISO 32000 Shared"), .target(name: "ISO 32000 7 Syntax"), .target(name: "ISO 32000 8 Graphics")]
        ),
        .target(
            name: "ISO 32000 13 Multimedia features",
            dependencies: [.target(name: "ISO 32000 Shared"), .target(name: "ISO 32000 7 Syntax")]
        ),
        .target(
            name: "ISO 32000 14 Document interchange",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .target(name: "ISO 32000 7 Syntax"),
                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
                .product(name: "Binary", package: "swift-binary"),
            ]
        ),
        .target(
            name: "ISO 32000 Annex D",
            dependencies: [
                .target(name: "ISO 32000 Shared"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),

        .target(
            name: "ISO 32000",
            dependencies: [
                .target(name: "ISO 32000 3 Terms and definitions"),
                .target(name: "ISO 32000 7 Syntax"),
                .target(name: "ISO 32000 8 Graphics"),
                .target(name: "ISO 32000 9 Text"),
                .target(name: "ISO 32000 10 Rendering"),
                .target(name: "ISO 32000 11 Transparency"),
                .target(name: "ISO 32000 12 Interactive features"),
                .target(name: "ISO 32000 13 Multimedia features"),
                .target(name: "ISO 32000 14 Document interchange"),
                .target(name: "ISO 32000 Annex D"),
                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Formatter", package: "swift-formatter"),
                .product(name: "Binary", package: "swift-binary"),
                .product(
                    name: "Binary",
                    package: "swift-binary"
                ),
                .product(
                    name: "Byte",
                    package: "swift-byte"
                ),
                .product(name: "ISO 9899", package: "swift-iso-9899"),
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "RFC 4648", package: "swift-rfc-4648"),
                .product(name: "Witness", package: "swift-witness"),
                .product(name: "Linear", package: "swift-linear"),
                .product(name: "Scale", package: "swift-scale"),
            ]
        ),
        .target(
            name: "ISO 32000 Flate",
            dependencies: [
                .target(name: "ISO 32000"),
                .target(name: "ISO 32000 Shared"),
                .product(name: "RFC 1950", package: "swift-rfc-1950"),
                .product(name: "W3C PNG", package: "swift-w3c-png"),
            ]
        ),
        .testTarget(
            name: "ISO 32000 Annex D Tests",
            dependencies: [
                .target(name: "ISO 32000"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .testTarget(
            name: "ISO 32000 Tests",
            dependencies: [
                .target(name: "ISO 32000"),
                .target(name: "ISO 32000 9 Text"),
                .target(name: "ISO 32000 Flate"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Binary", package: "swift-binary"),
                .product(name: "Formatter", package: "swift-formatter"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

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
