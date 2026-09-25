import 'package:flutter/material.dart';

/// Global navigator observer used by screens that need to know when they
/// return to the foreground of the navigator stack.
///
/// Registered in `MaterialApp.navigatorObservers` (see main.dart). Screens
/// that implement [RouteAware] subscribe to this observer in
/// `didChangeDependencies` and unsubscribe in `dispose`; the observer then
/// calls [RouteAware.didPopNext] whenever a route pushed on top of them is
/// popped.
///
/// Used by HomeScreen to reload all notes when the user returns from a
/// screen that may have changed them (notebook detail, editor, etc.).
final RouteObserver<PageRoute<dynamic>> appRouteObserver =
    RouteObserver<PageRoute<dynamic>>();
