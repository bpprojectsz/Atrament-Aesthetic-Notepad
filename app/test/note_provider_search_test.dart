import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/controlled_storage.dart';

void main() {
  late ControlledStorage storage;
  late NoteProvider provider;

  final alpha = testNote('a', 'Alpha');
  final beta = testNote('b', 'Beta');
  final gamma = testNote('g', 'Gamma');

  setUp(() {
    storage = ControlledStorage()..allNotes = [alpha, beta, gamma];
    provider = NoteProvider(storage: storage);
  });

  tearDown(() => provider.dispose());

  List<String> ids() => provider.notes.value.map((n) => n.id).toList()..sort();

  test('clearing the search on Home restores every note', () async {
    await provider.loadAllNotes();

    final search = provider.search('alpha', debounce: false);
    storage.searchCompleters.single.complete(
      StorageResult.success([alpha]),
    );
    await search;
    expect(ids(), ['a']);

    await provider.search('');

    expect(ids(), ['a', 'b', 'g'],
        reason: 'stale search results must not stay on screen');
    expect(provider.searchQuery.value, '');
  });

  test('clearing the search inside a notebook restores that notebook', () async {
    storage.notebookNotes['nb'] = [alpha, beta];
    await provider.loadNotebook('nb');

    final search = provider.search('gamma', debounce: false);
    storage.searchCompleters.single.complete(
      StorageResult.success([gamma]),
    );
    await search;
    expect(ids(), ['g']);

    await provider.search('   ');

    expect(ids(), ['a', 'b']);
  });

  test('fast typing sends only the final query to storage', () async {
    await provider.loadAllNotes();

    // Not awaited on purpose — this is what onChanged does per keystroke.
    provider.search('a');
    provider.search('al');
    provider.search('alp');
    expect(storage.searchCalls, isEmpty, reason: 'still inside the delay');

    await Future<void>.delayed(
      NoteProvider.searchDebounceDelay + const Duration(milliseconds: 150),
    );

    expect(storage.searchCalls, ['alp']);
  });

  test('debounce: false searches immediately', () async {
    await provider.loadAllNotes();

    provider.search('alpha', debounce: false);

    expect(storage.searchCalls, ['alpha']);
  });

  test('a late answer to an older query never replaces newer results', () async {
    await provider.loadAllNotes();

    final first = provider.search('alpha', debounce: false);
    final second = provider.search('beta', debounce: false);
    expect(storage.searchCalls, ['alpha', 'beta']);

    // The newer query answers first, then the slow older one arrives.
    storage.searchCompleters[1].complete(StorageResult.success([beta]));
    await second;
    storage.searchCompleters[0].complete(StorageResult.success([alpha]));
    await first;

    expect(ids(), ['b']);
    expect(provider.isLoading.value, isFalse);
  });

  test('a late search answer after the box was cleared is discarded', () async {
    await provider.loadAllNotes();

    final pending = provider.search('alpha', debounce: false);
    await provider.search('');
    expect(ids(), ['a', 'b', 'g']);

    storage.searchCompleters.single.complete(StorageResult.success([alpha]));
    await pending;

    expect(ids(), ['a', 'b', 'g'],
        reason: 'the old query must not bring its results back');
  });
}
