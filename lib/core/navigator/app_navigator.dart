import 'package:flutter/material.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';

class NavigatorRouter {
  static String get initialRoute => AuthRoutes.login;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get currentContext => navigatorKey.currentContext!;

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return await navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> push<T extends Object?>(Widget route) async {
    return await navigatorKey.currentState?.push<T>(
      MaterialPageRoute(builder: (_) => route),
    );
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget route, {
    TO? result,
  }) async {
    return await navigatorKey.currentState?.pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => route),
      result: result,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop<T>(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  static void popAll() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    return await navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
