import 'package:flutter/material.dart';

class NavigationManager {
  NavigationManager._();
  static NavigationManager navigationConfiguration = NavigationManager._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pushNamed(String nameScreen) => navigatorKey.currentState!.pushNamed(nameScreen);

  pushNamedReplacement(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  pop() {
    navigatorKey.currentState!.pop();
  }
}
