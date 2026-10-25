import 'dart:async';

import 'package:atrament/core/utils/error_handler.dart';
import 'package:flutter_test/flutter_test.dart';

// TEMPORARY: finds which async primitive stalls under the widget-test clock.
void main() {
  testWidgets('probe 1: cancelling a broadcast subscription completes', (tester) async {
    final c = StreamController<int>.broadcast();
    final sub = c.stream.listen((_) {});
    var done = false;
    unawaited(() async {
      await sub.cancel();
      done = true;
    }());
    await tester.pump(const Duration(milliseconds: 50));
    await c.close();
    if (!done) fail('Error: PROBE1 cancel() did not complete');
  });

  testWidgets('probe 2: Future.timeout on a completed future completes', (tester) async {
    final c = Completer<void>()..complete();
    var done = false;
    unawaited(() async {
      await c.future.timeout(const Duration(milliseconds: 200));
      done = true;
    }());
    await tester.pump(const Duration(milliseconds: 50));
    if (!done) fail('Error: PROBE2 timeout did not complete');
  });

  testWidgets('probe 3: ErrorHandler.report returns', (tester) async {
    var done = false;
    unawaited(() async {
      ErrorHandler.report(
        StateError('x'),
        StackTrace.current,
        message: 'm',
        context: 'c',
        severity: ErrorSeverity.warning,
      );
      done = true;
    }());
    await tester.pump(const Duration(milliseconds: 50));
    if (!done) fail('Error: PROBE3 report did not return');
  });

  testWidgets('probe 4: awaiting cancel inside finally after a return', (tester) async {
    final c = StreamController<int>.broadcast();
    Future<int> run() async {
      final sub = c.stream.listen((_) {});
      try {
        return 1;
      } finally {
        await sub.cancel();
      }
    }

    int? result;
    unawaited(run().then((v) => result = v));
    await tester.pump(const Duration(milliseconds: 50));
    await c.close();
    if (result == null) fail('Error: PROBE4 finally{await cancel()} did not complete');
  });
}
