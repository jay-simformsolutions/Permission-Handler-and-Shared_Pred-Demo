import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._internal();
  static final NavigationService instance = NavigationService._internal();

  late final NavigatorState currentState = navigationKey.currentState!;

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  dynamic goBack([dynamic popValue]) {
    return navigationKey.currentState!.pop(popValue);
  }

  BuildContext get context => currentState.context;

  void navigateToScreen(String page, {dynamic arguments}) =>
      navigationKey.currentState?.pushNamed(page, arguments: arguments);

  Future<void> replaceScreen(Widget page, {dynamic arguments}) async =>
      navigationKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );

  void popToFirst() =>
      navigationKey.currentState!.popUntil((route) => route.isFirst);
}
