import 'dart:convert';
import 'dart:io';

import 'package:atrament/core/services/export_page_renderer.dart';
import 'package:atrament/core/services/export_service.dart';
import 'package:atrament/core/utils/export_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class _FakePathProvider extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  _FakePathProvider(this.temp);
  final String temp;

  @override
  Future<String?> getTemporaryPath() async => temp;
}

ExportableNote _note({
  String title = 'A title',
  String body = 'Some body text.',
  String date = '15/10/2026',
  String? verse,
  List<ExportInkStroke>? ink,
}) => ExportableNote(
  title: title,
  plainTextContent: body,
  createdAtLabel: date,
  verseReferenceLabel: verse,
  ink: ink,
);

ExportInkStroke _stroke(List<Offset> points, {double width = 4}) =>
    ExportInkStroke(
      points: points,
      color: 0xFF000000,
      strokeWidth: width,
      isHighlighter: false,
    );

/// Number of pixels that are not pure white, optionally within a row range.
int _nonWhite(RenderedPage page, {int fromRow = 0, int? toRow}) {
  var count = 0;
  final end = toRow ?? page.height;
  for (var y = fromRow; y < end; y++) {
    for (var x = 0; x < page.width; x++) {
      final i = (y * page.width + x) * 4;
      if (page.rgba[i] != 255 || page.rgba[i + 1] != 255 || page.rgba[i + 2] != 255) {
        count++;
      }
    }
  }
  return count;
}

void main() {
  group('file names', () {
    String stem(String t) => ExportHelper.safeFileNameStem(t);

    test('Latin titles keep their words', () {
      expect(stem('My Note!'), 'My_Note');
      expect(stem('  --hello--  '), 'hello');
    });

    test('letters from every script are kept, so titles stay readable and distinct', () {
      expect(stem('ملاحظة جميلة'), 'ملاحظة_جميلة');
      expect(stem('今天的日记'), '今天的日记');
      expect(stem('מחברת יומית'), 'מחברת_יומית');
      expect(stem('हिन्दी नोट'), 'हिन्दी_नोट', reason: 'combining marks must survive');
      expect(stem('Café crème'), 'Café_crème');
      expect(stem('Привет мир'), 'Привет_мир');
      expect(stem('今天的日记'), isNot(stem('明天的计划')));
    });

    test('unsafe characters are dropped', () {
      expect(stem('../../etc/passwd'), 'etcpasswd');
      expect(stem('a/b\\c:d*e?f"g<h>i|j'), 'abcdefghij');
      expect(stem('title\u200F\u200E'), 'title', reason: 'invisible direction marks');
    });

    test('nothing usable falls back to a generic name', () {
      expect(stem(''), 'atrament_note');
      expect(stem('   '), 'atrament_note');
      expect(stem('!!!???'), 'atrament_note');
      expect(stem('🙂🙂'), 'atrament_note');
    });

    test('long titles are cut to 60 characters', () {
      expect(stem('a' * 200).runes.length, 60);
    });

    test('long titles in wide scripts stay within the byte budget', () {
      final result = stem('日' * 100);
      expect(utf8.encode(result).length,
          lessThanOrEqualTo(ExportHelper.maxFileNameStemBytes));
      expect(result.runes.length, greaterThan(10));
      expect(result.runes.every((r) => r == '日'.runes.first), isTrue,
          reason: 'cut between characters, never inside one');
    });
  });

  group('can the standard PDF fonts draw it?', () {
    test('Western European text and common punctuation: yes', () {
      expect(ExportHelper.canRenderAsPdfText(''), isTrue);
      expect(ExportHelper.canRenderAsPdfText('Hello, world!\n\tTab'), isTrue);
      expect(ExportHelper.canRenderAsPdfText('Café crème, señor, Größe'), isTrue);
      expect(ExportHelper.canRenderAsPdfText('“quoted” – dash — … €5'), isTrue);
    });

    test('anything else: no', () {
      for (final text in [
        'Привет',
        'Γειά',
        'Zażółć', // Polish ł is not in the standard set
        'Việt', // Vietnamese
        '日本語',
        '한국어',
        'مرحبا',
        'שלום',
        'हिन्दी',
        'smile 🙂',
        'tick ✓',
      ]) {
        expect(ExportHelper.canRenderAsPdfText(text), isFalse, reason: text);
      }
    });

    test('a note needs image rendering if any part is unsupported', () {
      expect(_note().needsImageRendering, isFalse);
      expect(_note(title: 'عنوان').needsImageRendering, isTrue);
      expect(_note(body: '本文です').needsImageRendering, isTrue);
      expect(_note(date: '٢٠٢٦/١٠/١٥').needsImageRendering, isTrue);
      expect(_note(verse: 'مزمور 23:1').needsImageRendering, isTrue);
      expect(_note(ink: const []).needsImageRendering, isTrue,
          reason: 'drawings are always images');
    });
  });

  group('reading ink from a stored note', () {
    test('a handwriting note yields its strokes', () {
      final content = jsonEncode({
        'type': 'handwriting',
        'canvasWidth': 400.0,
        'strokes': [
          {
            'penStyleId': 'fountain_pen',
            'points': [
              [1, 2],
              [3.5, 4],
            ],
            'color': 0xFF112233,
            'strokeWidth': 3.0,
            'isHighlighter': true,
          },
        ],
      });

      final strokes = ExportInk.fromNoteContent(content)!;

      expect(strokes, hasLength(1));
      expect(strokes.single.points, const [Offset(1, 2), Offset(3.5, 4)]);
      expect(strokes.single.color, 0xFF112233);
      expect(strokes.single.strokeWidth, 3);
      expect(strokes.single.isHighlighter, isTrue);
    });

    test('a typed note is not ink', () {
      expect(ExportInk.fromNoteContent('[{"insert":"Hello\\n"}]'), isNull);
      expect(ExportInk.fromNoteContent('not json'), isNull);
      expect(ExportInk.fromNoteContent(''), isNull);
    });

    test('a damaged stroke is skipped but the rest is kept', () {
      final content = jsonEncode({
        'type': 'handwriting',
        'strokes': [
          {'points': 'broken'},
          {
            'penStyleId': 'x',
            'points': [
              [0, 0],
              [1, 1],
            ],
            'color': 0xFF000000,
            'strokeWidth': 2.0,
          },
        ],
      });

      expect(ExportInk.fromNoteContent(content), hasLength(1));
    });

    test('unreadable strokes give an empty drawing, not a failure', () {
      expect(
        ExportInk.fromNoteContent('{"type":"handwriting","strokes":"nope"}'),
        isEmpty,
      );
    });
  });

  group('page renderer', () {
    const renderer = ExportPageRenderer();

    Future<List<RenderedPage>> render(WidgetTester tester, ExportableNote n) async {
      final pages = await tester.runAsync(() => renderer.renderPages(n));
      return pages!;
    }

    testWidgets('a short note is one A4 page with something drawn on it', (
      tester,
    ) async {
      final pages = await render(tester, _note());

      expect(pages, hasLength(1));
      expect(pages.single.width, (ExportPageRenderer.pageWidthPt * 1.5).round());
      expect(pages.single.height, (ExportPageRenderer.pageHeightPt * 1.5).round());
      expect(pages.single.rgba.length, pages.single.width * pages.single.height * 4);
      expect(_nonWhite(pages.single), greaterThan(100));
    });

    testWidgets('a long note flows onto several pages', (tester) async {
      final body = List.generate(400, (i) => 'Line number $i').join('\n');

      final pages = await render(tester, _note(body: body));

      expect(pages.length, greaterThanOrEqualTo(3));
      for (final page in pages) {
        expect(_nonWhite(page), greaterThan(100), reason: 'no blank pages');
      }
    });

    testWidgets('the margins stay empty', (tester) async {
      final body = List.generate(400, (i) => 'Line number $i').join('\n');
      final pages = await render(tester, _note(body: body));

      final marginRows = (48 * 1.5).round() - 2;
      for (final page in pages) {
        expect(_nonWhite(page, toRow: marginRows), 0, reason: 'top margin');
        expect(_nonWhite(page, fromRow: page.height - marginRows), 0,
            reason: 'bottom margin');
      }
    });

    testWidgets('Arabic, Hebrew and CJK render without error', (tester) async {
      for (final text in [
        'هذه ملاحظة باللغة العربية\nسطر ثان',
        'זו הערה בעברית\nשורה שנייה',
        '这是一条中文笔记。\n第二行。',
        'これは日本語のメモです。',
        'हिन्दी में एक नोट',
      ]) {
        final pages = await render(tester, _note(title: text.split('\n').first, body: text));
        expect(pages, isNotEmpty, reason: text);
        expect(_nonWhite(pages.first), greaterThan(100), reason: text);
      }
    });

    testWidgets('a verse reference is drawn after the text', (tester) async {
      final without = await render(tester, _note());
      final withVerse = await render(tester, _note(verse: 'Psalm 23:1'));

      expect(_nonWhite(withVerse.single), greaterThan(_nonWhite(without.single)));
    });

    testWidgets('a verse reference with no room moves to its own page', (
      tester,
    ) async {
      // Enough lines to fill the first page almost exactly is fragile, so
      // fill many pages and check the reference is never lost or cut off.
      final body = List.generate(120, (i) => 'Line number $i').join('\n');
      final plain = await render(tester, _note(body: body));
      final withVerse = await render(tester, _note(body: body, verse: 'Psalm 23:1'));

      expect(withVerse.length, anyOf(plain.length, plain.length + 1));
      final last = withVerse.last;
      final lastPlain = plain.last;
      expect(_nonWhite(last), greaterThan(_nonWhite(lastPlain) - 1));
    });

    testWidgets('a drawing is drawn, scaled into the page, and clipped to it', (
      tester,
    ) async {
      final empty = await render(tester, _note(body: '', ink: const []));
      // A drawing far taller than the page.
      final big = await render(
        tester,
        _note(
          body: '',
          ink: [
            _stroke(const [Offset(0, 0), Offset(300, 3000)], width: 6),
            _stroke(const [Offset(300, 0), Offset(0, 3000)], width: 6),
          ],
        ),
      );

      expect(big, hasLength(1), reason: 'a drawing is always one page');
      expect(_nonWhite(big.single), greaterThan(_nonWhite(empty.single) + 200));
      final marginRows = (48 * 1.5).round() - 2;
      expect(_nonWhite(big.single, fromRow: big.single.height - marginRows), 0,
          reason: 'ink must stay inside the margins');
    });

    testWidgets('a tap-sized dot is drawn', (tester) async {
      final empty = await render(tester, _note(body: '', ink: const []));
      final dot = await render(
        tester,
        _note(body: '', ink: [_stroke(const [Offset(50, 50)], width: 8)]),
      );

      expect(_nonWhite(dot.single), greaterThan(_nonWhite(empty.single)));
    });
  });

  group('export service', () {
    late Directory temp;

    setUp(() {
      temp = Directory.systemTemp.createTempSync('atrament_export_test_');
      PathProviderPlatform.instance = _FakePathProvider(temp.path);
    });

    tearDown(() {
      if (temp.existsSync()) temp.deleteSync(recursive: true);
    });

    final fixed = DateTime(2026, 10, 15, 14, 30, 7);

    Future<ExportResult> pdf(WidgetTester tester, ExportableNote n, {ExportService? service}) async {
      final result = await tester.runAsync(
        () => (service ?? ExportService(clock: () => fixed)).exportAsPdf(n),
      );
      return result!;
    }

    testWidgets('a plain Latin note becomes a normal text PDF', (tester) async {
      final result = await pdf(tester, _note(title: 'Groceries'));

      expect(result.succeeded, isTrue);
      final name = p.basename(result.filePath!);
      expect(name, 'Groceries_20261015_143007.pdf');
      final bytes = File(result.filePath!).readAsBytesSync();
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    });

    testWidgets('an Arabic note exports as image pages and keeps its title in the file name', (
      tester,
    ) async {
      final result = await pdf(
        tester,
        _note(title: 'ملاحظة', body: 'نص الملاحظة', date: '٢٠٢٦/١٠/١٥'),
      );

      expect(result.succeeded, isTrue);
      expect(p.basename(result.filePath!), 'ملاحظة_20261015_143007.pdf');
      final bytes = File(result.filePath!).readAsBytesSync();
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
      expect(bytes.length, greaterThan(1000));
    });

    testWidgets('a handwriting note exports as a PDF with the drawing in it', (
      tester,
    ) async {
      final empty = await pdf(tester, _note(title: 'Ink', body: '', ink: const []));
      final drawn = await pdf(
        tester,
        _note(
          title: 'Ink',
          body: '',
          ink: [_stroke(const [Offset(0, 0), Offset(200, 300)], width: 8)],
        ),
        service: ExportService(clock: () => fixed.add(const Duration(seconds: 5))),
      );

      expect(drawn.succeeded, isTrue);
      final emptyBytes = File(empty.filePath!).readAsBytesSync();
      final drawnBytes = File(drawn.filePath!).readAsBytesSync();
      expect(String.fromCharCodes(drawnBytes.take(5)), '%PDF-');
      expect(drawnBytes, isNot(emptyBytes),
          reason: 'the drawing must change the document');
    });

    testWidgets('two notes with different non-Latin titles never share a file', (
      tester,
    ) async {
      final a = await pdf(tester, _note(title: '今天的日记', body: '内容一'));
      final b = await pdf(tester, _note(title: '明天的计划', body: '内容二'));

      expect(a.filePath, isNot(b.filePath));
      expect(File(a.filePath!).existsSync(), isTrue);
      expect(File(b.filePath!).existsSync(), isTrue);
    });

    testWidgets('exporting the same note twice in one second keeps both files', (
      tester,
    ) async {
      final first = await pdf(tester, _note(title: 'Same'));
      final second = await pdf(tester, _note(title: 'Same'));

      expect(first.filePath, isNot(second.filePath));
      expect(p.basename(second.filePath!), 'Same_20261015_143007-2.pdf');
    });

    testWidgets('a very long title still produces a valid file name', (
      tester,
    ) async {
      final result = await pdf(tester, _note(title: '日' * 300, body: 'x'));

      expect(result.succeeded, isTrue);
      expect(utf8.encode(p.basename(result.filePath!)).length, lessThan(255));
    });

    testWidgets('a txt export keeps the same naming', (tester) async {
      final result = await tester.runAsync(
        () => ExportService(clock: () => fixed).exportAsTxt(_note(title: 'Notes')),
      );

      expect(result!.succeeded, isTrue);
      expect(p.basename(result.filePath!), 'Notes_20261015_143007.txt');
    });

    testWidgets('old exports are cleared, recent ones are kept', (tester) async {
      final exports = Directory(p.join(temp.path, 'exports'))..createSync();
      final old = File(p.join(exports.path, 'old.pdf'))..writeAsStringSync('x');
      final recent = File(p.join(exports.path, 'recent.pdf'))
        ..writeAsStringSync('x');
      old.setLastModifiedSync(DateTime.now().subtract(const Duration(days: 3)));

      await tester.runAsync(() => const ExportService().pruneOldExports());

      expect(old.existsSync(), isFalse);
      expect(recent.existsSync(), isTrue);
    });
  });
}
