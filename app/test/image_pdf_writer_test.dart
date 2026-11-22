import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:atrament/core/services/export_page_renderer.dart';
import 'package:atrament/core/services/image_pdf_builder.dart';
import 'package:atrament/core/services/image_pdf_writer.dart';
import 'package:atrament/core/utils/export_helper.dart';
import 'package:flutter_test/flutter_test.dart';

/// One embedded page image, read back out of a finished PDF.
class _Image {
  _Image(this.width, this.height, this.rgb);

  final int width;
  final int height;
  final Uint8List rgb;
}

/// Reads the embedded images back with nothing but string scanning and zlib.
/// (Bytes map 1:1 to Latin-1 characters, so string and byte indexes agree.)
List<_Image> _images(Uint8List pdf) {
  final text = latin1.decode(pdf);
  final pattern = RegExp(
    r'/Subtype /Image /Width (\d+) /Height (\d+) '
    r'/ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /FlateDecode '
    r'/Length (\d+) >>\nstream\n',
  );
  return [
    for (final m in pattern.allMatches(text))
      _Image(
        int.parse(m.group(1)!),
        int.parse(m.group(2)!),
        Uint8List.fromList(
          zlib.decode(
            pdf.sublist(m.end, m.end + int.parse(m.group(3)!)),
          ),
        ),
      ),
  ];
}

Uint8List _pattern(int width, int height, int seed) {
  final rgb = Uint8List(width * height * 3);
  for (var i = 0; i < rgb.length; i++) {
    rgb[i] = (i * 7 + seed * 31) % 256;
  }
  return rgb;
}

Uint8List _build(int pages, {int width = 5, int height = 3}) {
  final writer = ImagePdfWriter(pageWidthPt: 595.276, pageHeightPt: 841.89);
  for (var i = 0; i < pages; i++) {
    writer.addPage(
      rgb: _pattern(width, height, i),
      width: width,
      height: height,
    );
  }
  return writer.finish();
}

void main() {
  group('ImagePdfWriter structure', () {
    test('has a PDF header and end marker', () {
      final pdf = _build(2);
      final text = latin1.decode(pdf);

      expect(text.startsWith('%PDF-1.4\n'), isTrue);
      expect(text.endsWith('%%EOF\n'), isTrue);
    });

    test('startxref points at the xref table', () {
      final pdf = _build(3);
      final text = latin1.decode(pdf);
      final offset = int.parse(
        RegExp(r'startxref\n(\d+)\n%%EOF').firstMatch(text)!.group(1)!,
      );

      expect(text.substring(offset, offset + 5), 'xref\n');
    });

    test('every xref entry points at its own object', () {
      for (final pages in [1, 3, 25]) {
        final pdf = _build(pages);
        final text = latin1.decode(pdf);
        final xrefStart = int.parse(
          RegExp(r'startxref\n(\d+)\n%%EOF').firstMatch(text)!.group(1)!,
        );
        final header = RegExp(r'xref\n0 (\d+)\n').matchAsPrefix(text, xrefStart)!;
        final size = int.parse(header.group(1)!);
        expect(size, 3 + 3 * pages);

        // First entry is the free list head; each entry is exactly 20 bytes.
        var cursor = header.end;
        expect(text.substring(cursor, cursor + 20), '0000000000 65535 f \n');
        cursor += 20;
        for (var n = 1; n < size; n++) {
          final entry = text.substring(cursor, cursor + 20);
          expect(entry.endsWith(' n \n'), isTrue, reason: 'entry $n');
          final at = int.parse(entry.substring(0, 10));
          expect(
            text.substring(at, at + '$n 0 obj\n'.length),
            '$n 0 obj\n',
            reason: 'object $n ($pages pages)',
          );
          cursor += 20;
        }
        expect(text.substring(cursor).startsWith('trailer\n'), isTrue);
        expect(text.contains('/Size $size /Root 1 0 R'), isTrue);
      }
    });

    test('the page tree lists every page and counts them', () {
      final text = latin1.decode(_build(4));

      expect(text.contains('/Type /Pages'), isTrue);
      expect(text.contains('/Count 4'), isTrue);
      expect(
        RegExp(r'/Kids \[(\d+ 0 R ?){4}\]').hasMatch(text),
        isTrue,
      );
      expect('/Type /Page '.allMatches(text).length, 4);
    });

    test('pages use the given size', () {
      final text = latin1.decode(_build(1));

      expect(text.contains('/MediaBox [0 0 595.276 841.890]'), isTrue);
    });

    test('stream lengths match the real stream sizes', () {
      final text = latin1.decode(_build(2));
      for (final m in RegExp(r'/Length (\d+) >>\nstream\n').allMatches(text)) {
        final length = int.parse(m.group(1)!);
        final end = m.end + length;
        expect(
          text.substring(end).startsWith('endstream') ||
              text.substring(end).startsWith('\nendstream'),
          isTrue,
        );
      }
    });
  });

  group('ImagePdfWriter content', () {
    test('every page image decompresses to exactly what was added', () {
      final pdf = _build(6, width: 7, height: 4);
      final images = _images(pdf);

      expect(images, hasLength(6));
      for (var i = 0; i < 6; i++) {
        expect(images[i].width, 7);
        expect(images[i].height, 4);
        expect(images[i].rgb, _pattern(7, 4, i), reason: 'page $i');
      }
    });

    test('a white page-sized image compresses to a small stream', () {
      final writer = ImagePdfWriter(pageWidthPt: 595.276, pageHeightPt: 841.89);
      final white = Uint8List(893 * 1263 * 3)..fillRange(0, 893 * 1263 * 3, 255);
      writer.addPage(rgb: white, width: 893, height: 1263);

      final pdf = writer.finish();

      expect(pdf.length, lessThan(40 * 1024));
      expect(_images(pdf).single.rgb, white);
    });

    test('rgbFromRgba drops the alpha channel and keeps colours in order', () {
      final rgba = Uint8List.fromList([1, 2, 3, 255, 4, 5, 6, 128]);

      expect(
        ImagePdfWriter.rgbFromRgba(rgba, 2, 1),
        Uint8List.fromList([1, 2, 3, 4, 5, 6]),
      );
    });

    test('an empty document is still well formed', () {
      final text = latin1.decode(_build(0));

      expect(text.contains('/Count 0'), isTrue);
      expect(text.endsWith('%%EOF\n'), isTrue);
    });
  });

  group('ImagePdfBuilder', () {
    const note = ExportableNote(
      title: '标题',
      plainTextContent: '第一行\n第二行\n第三行',
      createdAtLabel: '2026-11-21',
    );

    testWidgets('builds one image page per rendered page', (tester) async {
      final built = await tester.runAsync(() async {
        final hashes = <int, Uint8List>{};
        final result = await const ImagePdfBuilder().build(
          note,
          onPageRgb: (i, rgb) => hashes[i] = rgb,
        );
        final streamed = await const ExportPageRenderer()
            .renderPageStream(note)
            .length;
        return (result, hashes, streamed);
      });
      final (result, rgbs, streamedCount) = built!;

      expect(result.pageCount, streamedCount);
      expect(result.pageCount, greaterThanOrEqualTo(1));
      final images = _images(result.bytes);
      expect(images, hasLength(result.pageCount));
      for (var i = 0; i < images.length; i++) {
        expect(images[i].rgb, rgbs[i], reason: 'page $i content');
        expect(images[i].width, 893);
        expect(images[i].height, 1263);
      }
    });

    testWidgets('the streamed pages equal the all-at-once pages', (tester) async {
      final both = await tester.runAsync(() async {
        const renderer = ExportPageRenderer();
        final all = await renderer.renderPages(note);
        final streamed = await renderer.renderPageStream(note).toList();
        return (all, streamed);
      });
      final (all, streamed) = both!;

      expect(streamed, hasLength(all.length));
      for (var i = 0; i < all.length; i++) {
        expect(streamed[i].rgba, all[i].rgba);
      }
    });
  });
}
