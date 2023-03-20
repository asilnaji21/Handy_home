import 'package:flutter/material.dart';

class NavigationManager {


  NavigationManager._();
  static NavigationManager navigationConfiguration =
      NavigationManager._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false);

  void navigateTo(context, widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

  void navigateToo(nameScreen) =>
      navigatorKey.currentState!.pushNamed(nameScreen);
}