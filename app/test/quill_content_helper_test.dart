import 'package:atrament/core/utils/quill_content_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('plainTextFromContent', () {
    test('empty string returns empty', () {
      expect(plainTextFromContent(''), '');
      expect(plainTextFromContent('   '), '');
    });

    test('handwriting wrapper returns empty', () {
      const raw = '{"type":"handwriting","strokes":[]}';
      expect(plainTextFromContent(raw), '');
    });

    test('Quill delta with text returns the plain text', () {
      const raw = '[{"insert":"Hello\\n"},{"insert":"World\\n"}]';
      expect(plainTextFromContent(raw), 'Hello\nWorld\n');
    });

    test('malformed JSON returns empty without throwing', () {
      expect(plainTextFromContent('not json'), '');
      expect(plainTextFromContent('[broken'), '');
    });

    test('non-array non-map JSON returns empty', () {
      expect(plainTextFromContent('"just a string"'), '');
      expect(plainTextFromContent('42'), '');
    });
  });

  group('firstNonEmptyLine', () {
    test('empty text returns empty', () {
      expect(firstNonEmptyLine(''), '');
      expect(firstNonEmptyLine('   \n  \n'), '');
    });

    test('skips leading blank lines', () {
      expect(firstNonEmptyLine('\n\n  First real line\nsecond'), 'First real line');
    });

    test('returns first line when shorter than maxLength', () {
      expect(firstNonEmptyLine('Short\nSecond'), 'Short');
    });

    test('truncates with ellipsis when longer than maxLength', () {
      final long = 'A' * 100;
      final result = firstNonEmptyLine(long);
      expect(result.length, 61);
      expect(result.endsWith('…'), isTrue);
    });

    test('respects custom maxLength', () {
      final result = firstNonEmptyLine('ABCDEFGHIJ', maxLength: 5);
      expect(result, 'ABCDE…');
    });
  });
}
