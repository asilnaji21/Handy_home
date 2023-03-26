import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/view/authentication/emailconfirmation_view.dart';
import 'package:handy_home_app/presentation/view/authentication/emailverification_view.dart';
import 'package:handy_home_app/presentation/view/authentication/login_view.dart';
import '../../presentation/view/authentication/newpassword_view.dart';
import '../../presentation/view/authentication/restorepassword_view.dart';
import '../../presentation/view/authentication/signup_view.dart';
import '../../presentation/view/onBoarding/onboarding.dart';
import '../../presentation/view/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case RouteConstants.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RouteConstants.signupRoute:
        return MaterialPageRoute(builder: (_) => SigUpView());

      case RouteConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());

      case RouteConstants.restorePasswordRoute:
        return MaterialPageRoute(builder: (_) => RestorPasswordView());

      case RouteConstants.newPasswordRoute:
        return MaterialPageRoute(builder: (_) => NewPasswordView());

      case RouteConstants.emailVerificationRoute:
        return MaterialPageRoute(builder: (_) => EmailVerificationView());
      case RouteConstants.emailConfirmationRoute:
        return MaterialPageRoute(builder: (_) => EmailConfirmationView());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
