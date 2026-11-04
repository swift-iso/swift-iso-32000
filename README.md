# swift-iso-32000

Use this package when you need to write PDF files from Swift at the level of the format itself: pages, content streams of drawing and text operators, fonts, images, links and outlines. Start from `ISO_32000.Document`, fill its pages with `ISO_32000.ContentStream`, and turn it into bytes with `ISO_32000.Writer`. Add the `ISO 32000 Flate` product to compress streams and to use PNG images. If you want to lay out pages from views instead of operators, use swift-pdf-render, and to generate PDFs from HTML or Markdown, use swift-pdf.

## Laws

- Lengths and coordinates in user space are quantized to 0.01 units. Helvetica's 556-unit "a" at 12 points is 6.67 wide, not 6.672.
- Real numbers are written with at most five decimal places, rounded, with trailing zeros dropped and never in exponent form. A rounding carry goes into the integer part. Infinity and NaN are written as 0, negative zero as 0, and magnitudes beyond `UInt64` are clamped.
- Dictionary keys are written in sorted order, and fonts and images are written in order of resource name.
- An image's resource name comes from an identifier drawn from a process-wide counter when the `ISO_32000.Image` is created. Two images made from the same bytes are two resources, and the names in the output depend on how many images the process made before.
- A name is 1 to 127 bytes with no NUL or white space. Delimiters, `#` and any byte that isn't visible ASCII are written as `#` and two hex digits.
- A text string is written in PDFDocEncoding when every character fits, and otherwise as UTF-16BE with a byte order mark. Reading picks UTF-16BE or UTF-8 from a byte order mark and PDFDocEncoding otherwise, with U+FFFD for an undefined byte.
- `ISO_32000.ContentStream.Builder.showText(_:)` with a `String` encodes it as WinAnsi. A character WinAnsi lacks goes through a small fallback map, for example an arrow becomes `->` and a check mark `*`, and anything still unmapped becomes `?`. Width measurement doesn't use that map: a character outside WinAnsi counts as the font's default width, so measured and drawn text can differ.
- The writer only writes the fonts and images listed in a page's `ISO_32000.Resources`. The fonts and images a content stream records as it is built are not consulted. Resources with the same name on several pages are written once, with the last page's value.
- The standard 14 fonts are written unembedded as Type 1 fonts with WinAnsi encoding, except Symbol and ZapfDingbats, which keep their built-in encodings. An embedded TrueType font is written as given, with WinAnsi encoding, a ToUnicode map and widths for codes 32 to 255 scaled to 1000 units per em.
- `ISO_32000.Writer` compresses nothing by default. With compression, such as `ISO_32000.Writer.flate(level:)`, content streams, embedded font programs and ToUnicode maps are compressed only when that makes them smaller. Image data is written as it is, with the filter the image already carries.
- A page's media box, crop box and a rotation other than 0 are written. Bleed, trim and art boxes, and the document's viewer preferences, are not.
- Of the annotations, only links are written, to a URI or a destination. An outline item whose target is an action is written without a destination. A destination whose page index is out of range points at the first page.
- `ISO_32000.Version.default` is PDF 1.7.
- Dates are written as `D:` followed by year, month, day, hour, minute and second, with no time zone. The fields are not checked.
- `ISO_32000.Image.init(jpeg:)` reads only the header. One, three or four components become DeviceGray, DeviceRGB or DeviceCMYK, and the JPEG bytes are embedded unchanged. A PNG loses its alpha channel, has its palette expanded to RGB, and is compressed again with zlib.
- Restoring a graphics state stack that holds only its initial state does nothing and returns false.
