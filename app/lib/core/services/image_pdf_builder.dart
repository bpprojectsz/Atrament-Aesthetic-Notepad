import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/export_helper.dart';
import 'export_page_renderer.dart';

/// A finished image-based PDF.
class ImagePdfResult {
  const ImagePdfResult({required this.bytes, required this.pageCount});

  final Uint8List bytes;
  final int pageCount;
}

/// Builds the page-image PDF used for handwriting and for scripts the
/// standard PDF fonts cannot draw (see [ExportableNote.needsImageRendering]).
class ImagePdfBuilder {
  const ImagePdfBuilder({this.renderer = const ExportPageRenderer()});

  final ExportPageRenderer renderer;

  Future<ImagePdfResult> build(ExportableNote note) async {
    final pages = await renderer.renderPages(note);
    final document = pw.Document();
    for (final page in pages) {
      final image = pw.RawImage(
        bytes: page.rgba,
        width: page.width,
        height: page.height,
      );
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (_) => pw.Image(
            image,
            width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.height,
            fit: pw.BoxFit.fill,
          ),
        ),
      );
    }
    return ImagePdfResult(bytes: await document.save(), pageCount: pages.length);
  }
}
