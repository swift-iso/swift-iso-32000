# swift-iso-32000

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Swift implementation of ISO 32000: Document management — Portable Document Format (PDF).

## Overview

This package encodes the ISO 32000-2 (PDF 2.0) specification clause by clause, with one target per clause — syntax (objects, cross-reference tables), graphics, text, rendering, transparency, interactive features, multimedia, and document interchange — under the `ISO_32000` namespace. A separate `ISO 32000 Flate` target adds Flate/PNG-predictor decompression, composing RFC 1950 and W3C PNG. It depends on sibling standards packages (ISO 9899, IEEE 754, RFC 1950, RFC 4648, IEC 61966, W3C PNG, ISO 14496-22) and on swift-primitives for geometry, binary, and byte handling.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-iso/swift-iso-32000.git", from: "0.4.1")
]
```

## License

This package is licensed under the Apache License 2.0. See [LICENSE.md](LICENSE.md) for details.
