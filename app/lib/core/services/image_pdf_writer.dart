import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Writes a PDF whose pages are full-page RGB images, keeping only the
/// compressed bytes of each page.
///
/// Every page is deflated (lossless, standard `FlateDecode`) the moment it
/// is added, so the caller can drop its page bitmap straight away. A typical
/// text page shrinks from 3.4 MB of RGB to about 20 KB, so memory stays flat
/// however many pages there are. (The general-purpose PDF library keeps each
/// page's raw bitmap until the whole document is saved, which needed about
/// 17 MB per page.)
///
/// File layout (PDF 1.4, one revision, classic cross-reference table):
///   object 1 = catalog, object 2 = page tree (written last),
///   then per page i: image, content stream, page object (3 + 3i ...).
class ImagePdfWriter {
  ImagePdfWriter({required this.pageWidthPt, required this.pageHeightPt}) {
    _write('%PDF-1.4\n');
    // A comment of high-bit bytes marks the file as binary for tools.
    _out
      ..addByte(0x25)
      ..add(const [0xE2, 0xE3, 0xCF, 0xD3])
      ..addByte(0x0A);
    _length += 6;
  }

  /// Page size in PDF points (A4 is 595.28 x 841.89).
  final double pageWidthPt;
  final double pageHeightPt;

  final BytesBuilder _out = BytesBuilder(copy: false);
  final Map<int, int> _offsets = {};
  final List<int> _pageObjects = [];
  int _length = 0;
  int _nextObject = 3;
  bool _finished = false;

  int get pageCount => _pageObjects.length;

  /// Converts RGBA pixels to RGB (the pages are opaque, so alpha is dropped).
  static Uint8List rgbFromRgba(Uint8List rgba, int width, int height) {
    final pixels = width * height;
    final rgb = Uint8List(pixels * 3);
    var from = 0;
    var to = 0;
    for (var i = 0; i < pixels; i++) {
      rgb[to] = rgba[from];
      rgb[to + 1] = rgba[from + 1];
      rgb[to + 2] = rgba[from + 2];
      from += 4;
      to += 3;
    }
    return rgb;
  }

  /// Adds one page. [rgb] is `width * height * 3` bytes, top row first.
  /// It is compressed here and not kept.
  void addPage({
    required Uint8List rgb,
    required int width,
    required int height,
  }) {
    assert(!_finished, 'addPage after finish');
    assert(rgb.length == width * height * 3, 'rgb has the wrong length');

    final image = _nextObject++;
    final content = _nextObject++;
    final page = _nextObject++;

    final compressed = Uint8List.fromList(zlib.encode(rgb));
    _beginObject(image);
    _write(
      '<< /Type /XObject /Subtype /Image /Width $width /Height $height '
      '/ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /FlateDecode '
      '/Length ${compressed.length} >>\nstream\n',
    );
    _writeBytes(compressed);
    _write('\nendstream\nendobj\n');

    final w = _num(pageWidthPt);
    final h = _num(pageHeightPt);
    final draw = 'q $w 0 0 $h 0 0 cm\n/Im0 Do\nQ\n';
    _beginObject(content);
    _write('<< /Length ${draw.length} >>\nstream\n$draw'
        'endstream\nendobj\n');

    _beginObject(page);
    _write(
      '<< /Type /Page /Parent 2 0 R /MediaBox [0 0 $w $h] '
      '/Resources << /XObject << /Im0 $image 0 R >> >> '
      '/Contents $content 0 R >>\nendobj\n',
    );
    _pageObjects.add(page);
  }

  /// Completes the file and returns its bytes. Call once.
  Uint8List finish() {
    assert(!_finished, 'finish called twice');
    _finished = true;

    _beginObject(2);
    final kids = _pageObjects.map((n) => '$n 0 R').join(' ');
    _write('<< /Type /Pages /Kids [$kids] /Count ${_pageObjects.length} >>\n'
        'endobj\n');

    _beginObject(1);
    _write('<< /Type /Catalog /Pages 2 0 R >>\nendobj\n');

    final xrefOffset = _length;
    final size = _nextObject;
    final xref = StringBuffer('xref\n0 $size\n')
      ..write('0000000000 65535 f \n');
    for (var n = 1; n < size; n++) {
      xref.write('${_offsets[n]!.toString().padLeft(10, '0')} 00000 n \n');
    }
    _write('$xref'
        'trailer\n<< /Size $size /Root 1 0 R >>\n'
        'startxref\n$xrefOffset\n%%EOF\n');
    return _out.takeBytes();
  }

  void _beginObject(int number) {
    _offsets[number] = _length;
    _write('$number 0 obj\n');
  }

  void _write(String ascii) => _writeBytes(latin1.encode(ascii));

  void _writeBytes(List<int> bytes) {
    _out.add(bytes);
    _length += bytes.length;
  }

  static String _num(double value) => value.toStringAsFixed(3);
}
