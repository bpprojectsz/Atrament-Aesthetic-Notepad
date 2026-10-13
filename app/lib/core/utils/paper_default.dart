import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

/// The paper style id chosen as the default in Settings ('cream' until the
/// user picks one). New notes and new notebooks start with it.
Future<String> loadDefaultPaperStyleId() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.prefPaperStyleDefault) ?? 'cream';
  } catch (_) {
    return 'cream';
  }
}
