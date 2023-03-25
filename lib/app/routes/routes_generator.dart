import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/view/signup_view.dart';

import '../../presentation/view/onBoarding/onboarding.dart';

import '../../presentation/view/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case RouteConstants.onBoardingRoute :
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RouteConstants. sigUpRoute:
        return MaterialPageRoute(builder: (_) => const SigUpScreen());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
