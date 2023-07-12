import 'package:flutter/material.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static pushNamed(String nameScreen, {Object? arguments}) =>
      navigatorKey.currentState!.pushNamed(nameScreen, arguments: arguments);

  static pushNamedReplacement(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static goToAndRemove(String routeName, {Object? argument}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: argument);
  }

  static pop() {
    navigatorKey.currentState!.pop();
  }

  static popUntil(String screenName) {
    navigatorKey.currentState!
        .popUntil(ModalRoute.withName(screenName));
  }
}
