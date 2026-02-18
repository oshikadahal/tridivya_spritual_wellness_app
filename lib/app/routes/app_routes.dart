import 'package:flutter/material.dart';

/// A small helper to perform navigation without needing a [BuildContext].
///
/// Usage:
/// - Set `navigatorKey: AppRoutes.navigatorKey` on your `MaterialApp`.
/// - Call `AppRoutes.push(MyPage());` from anywhere.
class AppRoutes {
  AppRoutes._();

  /// Use this key in MaterialApp so we can navigate without a BuildContext.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get _nav => navigatorKey.currentState;

  static Future<T?> push<T extends Object?>(Widget page) {
    return _nav!.push<T>(MaterialPageRoute(builder: (_) => page));
  }

  static Future<T?> pushNamed<T extends Object?>(String name, {Object? arguments}) {
    return _nav!.pushNamed<T>(name, arguments: arguments);
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(Widget page, {TO? result}) {
    return _nav!.pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page), result: result);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(String name, {TO? result, Object? arguments}) {
    return _nav!.pushReplacementNamed<T, TO>(name, result: result, arguments: arguments);
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(Widget page) {
    return _nav!.pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  static void pop<T extends Object?>([T? result]) {
    _nav?.pop<T>(result);
  }

  static void popToFirst() {
    _nav?.popUntil((route) => route.isFirst);
  }
}