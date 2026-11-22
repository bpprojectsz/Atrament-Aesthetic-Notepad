import 'dart:typed_data';

import '../utils/export_helper.dart';
import 'export_page_renderer.dart';
import 'image_pdf_writer.dart';

/// A finished image-based PDF.
class ImagePdfResult {
  const ImagePdfResult({required this.bytes, required this.pageCount});

  final Uint8List bytes;
  final int pageCount;
}

/// Builds the page-image PDF used for handwriting and for scripts the
/// standard PDF fonts cannot draw (see [ExportableNote.needsImageRendering]).
///
/// Pages are rendered one at a time and compressed straight away, so memory
/// use does not grow with the page count (see [ImagePdfWriter]).
class ImagePdfBuilder {
  const ImagePdfBuilder({this.renderer = const ExportPageRenderer()});

  final ExportPageRenderer renderer;

  /// [onPageRgb] is for tests and measurements: it receives each page's RGB
  /// bytes before they are compressed.
  Future<ImagePdfResult> build(
    ExportableNote note, {
    void Function(int index, Uint8List rgb)? onPageRgb,
  }) async {
    final writer = ImagePdfWriter(
      pageWidthPt: ExportPageRenderer.pageWidthPt,
      pageHeightPt: ExportPageRenderer.pageHeightPt,
    );
    var index = 0;
    await for (final page in renderer.renderPageStream(note)) {
      final rgb = ImagePdfWriter.rgbFromRgba(page.rgba, page.width, page.height);
      onPageRgb?.call(index, rgb);
      writer.addPage(rgb: rgb, width: page.width, height: page.height);
      index++;
    }
    return ImagePdfResult(bytes: writer.finish(), pageCount: index);
  }
}
