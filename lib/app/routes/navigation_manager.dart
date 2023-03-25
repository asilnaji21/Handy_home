import 'package:flutter/material.dart';

class NavigationManager {
  NavigationManager._();
  static NavigationManager navigationConfiguration = NavigationManager._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void navigateAndFinish(context, Widget) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Widget),
      );

  void navigateTo(context, widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

  void navigateToUnderScreen(nameScreen) =>
      navigatorKey.currentState!.pushNamed(nameScreen);
 
  }

