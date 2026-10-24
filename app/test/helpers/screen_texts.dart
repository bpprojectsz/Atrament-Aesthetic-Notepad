import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Expects [message] to be on screen. If it is not, fails with a list of
/// everything that is, which makes a missing snackbar easy to diagnose.
void expectOnScreen(WidgetTester tester, String message) {
  if (find.text(message).evaluate().length == 1) return;
  final texts = tester
      .widgetList<Text>(find.byType(Text))
      .map((t) => t.data ?? t.textSpan?.toPlainText())
      .whereType<String>()
      .toList();
  final snackBars = find.byType(SnackBar).evaluate().length;
  final lines = <String>[
    'Error: expected exactly one "$message" but found '
        '${find.text(message).evaluate().length}; '
        'SnackBars on screen: $snackBars',
    for (var i = 0; i < texts.length && i < 40; i++) 'Error: on screen [$i]: ${texts[i]}',
  ];
  fail(lines.join('\n'));
}
