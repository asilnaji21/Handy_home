import 'package:flutter/material.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static pushNamed(String nameScreen,{Object? arguments}) =>
      navigatorKey.currentState!.pushNamed(nameScreen,arguments: arguments);

  static pushNamedReplacement(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static goToAndRemove(String routeName) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  static pop() {
    navigatorKey.currentState!.pop();
  }
}
