import 'package:atrament/core/models/note_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime(2026, 1, 15, 9, 30);
  final modifiedAt = DateTime(2026, 1, 16, 10, 0);

  NoteModel buildNote({String? verseReference}) {
    return NoteModel(
      id: 'note_1',
      title: 'Morning Thoughts',
      content: '[{"insert":"Hello world\\n"}]',
      notebookId: 'notebook_1',
      paperStyle: 'cream',
      createdAt: createdAt,
      modifiedAt: modifiedAt,
      verseReference: verseReference,
    );
  }

  group('NoteModel', () {
    test('toJson/fromJson round-trips exactly', () {
      final note = buildNote(verseReference: 'Psalm 46:1');
      final json = note.toJson();
      final restored = NoteModel.fromJson(json);

      expect(restored, equals(note));
    });

    test('toJson/fromJson round-trips with null verseReference', () {
      final note = buildNote();
      final restored = NoteModel.fromJson(note.toJson());

      expect(restored.verseReference, isNull);
      expect(restored, equals(note));
    });

    test('copyWith overrides only the specified fields', () {
      final note = buildNote();
      final updated = note.copyWith(title: 'Evening Thoughts');

      expect(updated.title, 'Evening Thoughts');
      expect(updated.id, note.id);
      expect(updated.content, note.content);
      expect(updated.notebookId, note.notebookId);
      expect(updated.createdAt, note.createdAt);
    });

    test('copyWith with clearVerseReference removes the reference', () {
      final note = buildNote(verseReference: 'John 3:16');
      final updated = note.copyWith(clearVerseReference: true);

      expect(updated.verseReference, isNull);
    });

    test('copyWith without clearVerseReference preserves existing reference', () {
      final note = buildNote(verseReference: 'John 3:16');
      final updated = note.copyWith(title: 'New title');

      expect(updated.verseReference, 'John 3:16');
    });

    test('equality is value-based, not identity-based', () {
      final a = buildNote(verseReference: 'Romans 8:28');
      final b = buildNote(verseReference: 'Romans 8:28');

      expect(identical(a, b), isFalse);
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('equality fails when any field differs', () {
      final a = buildNote();
      final b = buildNote().copyWith(title: 'Different title');

      expect(a, isNot(equals(b)));
    });

    test('fromJson throws on malformed input rather than silently corrupting data', () {
      expect(
        () => NoteModel.fromJson(const <String, dynamic>{'id': 'note_1'}),
        throwsA(anything),
      );
    });
  });
}
