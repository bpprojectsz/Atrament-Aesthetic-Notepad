import 'package:atrament/core/models/note_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime(2026, 1, 15, 9, 30);
  final modifiedAt = DateTime(2026, 1, 16, 10, 0);

  NoteModel buildNote({String? verseReference, String? notebookId = 'notebook_1'}) {
    return NoteModel(
      id: 'note_1',
      title: 'Morning Thoughts',
      content: '[{"insert":"Hello world\\n"}]',
      notebookId: notebookId,
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

    test('notebookId may be null - round-trips through JSON', () {
      final note = buildNote(notebookId: null);
      expect(note.notebookId, isNull);
      final restored = NoteModel.fromJson(note.toJson());
      expect(restored.notebookId, isNull);
      expect(restored, equals(note));
    });

    test('copyWith clearNotebook sets notebookId to null', () {
      final note = buildNote();
      expect(note.notebookId, isNotNull);
      final cleared = note.copyWith(clearNotebook: true);
      expect(cleared.notebookId, isNull);
    });

    test('copyWith without clearNotebook preserves notebookId', () {
      final note = buildNote();
      final updated = note.copyWith(title: 'New title');
      expect(updated.notebookId, note.notebookId);
    });

    test('copyWith can set notebookId from null to a value', () {
      final note = buildNote(notebookId: null);
      final filed = note.copyWith(notebookId: 'nb_sermons');
      expect(filed.notebookId, 'nb_sermons');
    });

    test('equality distinguishes null and non-null notebookId', () {
      final a = buildNote(notebookId: null);
      final b = buildNote(notebookId: 'nb_x');
      expect(a, isNot(equals(b)));
    });
  });
}
