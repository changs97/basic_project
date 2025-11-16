import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get _nav => navigatorKey.currentState;

  static Future<T?> pushNamedSafe<T extends Object?>(String route, {Object? arguments}) async {
    final nav = _nav;
    if (nav == null || !mounted) return null;
    return nav.pushNamed<T>(route, arguments: arguments);
  }

  static Future<T?> pushReplacementNamedSafe<T extends Object?, TO extends Object?>(
      String route, {
        TO? result,
        Object? arguments,
      }) async {
    final nav = _nav;
    if (nav == null || !mounted) return null;
    return nav.pushReplacementNamed<T, TO>(route, result: result, arguments: arguments);
  }

  static Future<T?> pushNamedAndRemoveUntilSafe<T extends Object?>(
      String newRouteName,
      RoutePredicate predicate, {
        Object? arguments,
      }) async {
    final nav = _nav;
    if (nav == null || !mounted) return null;
    return nav.pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
  }

  static void popSafe<T extends Object?>([T? result]) {
    final nav = _nav;
    if (nav == null || !mounted) return;
    if (nav.canPop()) {
      nav.pop<T>(result);
    }
  }

  static bool get mounted => navigatorKey.currentContext != null;
}

extension NavigationContextX on BuildContext {
  Future<T?> pushNamedSafe<T extends Object?>(String route, {Object? arguments}) {
    final nav = Navigator.maybeOf(this);
    if (nav == null) return Future.value(null);
    return nav.pushNamed<T>(route, arguments: arguments);
  }

  void popSafe<T extends Object?>([T? result]) {
    final nav = Navigator.maybeOf(this);
    if (nav != null && nav.canPop()) {
      nav.pop<T>(result);
    }
  }
}


