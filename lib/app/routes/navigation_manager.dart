import 'package:flutter/material.dart';

class NavigationManager {

static  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

 static pushNamed(String nameScreen) => navigatorKey.currentState!.pushNamed(nameScreen);

 static pushNamedReplacement(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

 static pop() {
    navigatorKey.currentState!.pop();
  }
}
