// Memory probe for the image-PDF export. NOT part of the normal test run
// (it lives outside test/); the "measure-pdf" CI task runs it for several
// page counts, each in a fresh process:
//
//   flutter test tool/perf/pdf_memory_probe_test.dart \
//       --dart-define=PAGES=50 --dart-define=LABEL=abc1234
//
// It builds a long Chinese note (which needs the image path) and reports the
// process's peak resident memory growth while the PDF is built. Numbers are
// approximate: they include the test engine and the Dart garbage collector's
// timing, and the test font is wider than real fonts, so the useful reading
// is how memory grows with the page count, before versus after a change.
import 'dart:io';

import 'package:atrament/core/services/image_pdf_builder.dart';
import 'package:atrament/core/utils/export_helper.dart';
import 'package:flutter_test/flutter_test.dart';

const int _pages = int.fromEnvironment('PAGES', defaultValue: 10);
const String _label = String.fromEnvironment('LABEL', defaultValue: 'local');

/// About 41 lines fit on a page (38 on the first, which has the header).
ExportableNote _note(int pages) {
  final lines = 38 + 41 * (pages - 1) - 1;
  final body = List.generate(
    lines,
    (i) => '测试行 $i 这是一段用于测量内存的中文文本',
  ).join('\n');
  return ExportableNote(
    title: '内存测量',
    plainTextContent: body,
    createdAtLabel: '2026-11-21',
  );
}

double _mb(int bytes) => bytes / (1024 * 1024);

void main() {
  testWidgets('image PDF memory: $_pages pages', (tester) async {
    await tester.runAsync(() async {
      const builder = ImagePdfBuilder();

      // Warm-up: one page, so fonts, caches and engine start-up are not
      // counted as growth.
      await builder.build(_note(1));

      final baseline = ProcessInfo.currentRss;
      final peakBefore = ProcessInfo.maxRss;
      final watch = Stopwatch()..start();

      final result = await builder.build(_note(_pages));

      watch.stop();
      final peakAfter = ProcessInfo.maxRss;
      final current = ProcessInfo.currentRss;

      final lines = <String>[
        'label: $_label',
        'pages requested: $_pages',
        'pages built: ${result.pageCount}',
        'pdf size MB: ${_mb(result.bytes.length).toStringAsFixed(2)}',
        'seconds: ${(watch.elapsedMilliseconds / 1000).toStringAsFixed(1)}',
        'baseline rss MB: ${_mb(baseline).toStringAsFixed(0)}',
        'peak rss before MB: ${_mb(peakBefore).toStringAsFixed(0)}',
        'peak rss after MB: ${_mb(peakAfter).toStringAsFixed(0)}',
        'peak growth MB: ${_mb(peakAfter - peakBefore).toStringAsFixed(0)}'
            '${peakAfter == peakBefore ? " (no growth: lower bound)" : ""}',
        'rss after MB: ${_mb(current).toStringAsFixed(0)}',
      ];
      for (final line in lines) {
        stdout.writeln(line);
      }

      final dir = Directory('../reports/pdf_memory')
        ..createSync(recursive: true);
      File('${dir.path}/${_label}_$_pages.txt')
          .writeAsStringSync('${lines.join('\n')}\n');
    });
  }, timeout: const Timeout(Duration(minutes: 12)));
}
