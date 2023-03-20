import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/view/login_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case RouteConstants.signupRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
