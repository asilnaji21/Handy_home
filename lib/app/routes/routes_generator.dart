import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/presentation/view/authentication/emailconfirmation_view.dart';
import 'package:handy_home_app/presentation/view/authentication/emailverification_view.dart';
import 'package:handy_home_app/presentation/view/authentication/login_view.dart';
import 'package:handy_home_app/presentation/view/bnb/app_bnb.dart';
import '../../bussiness logic/onboardingManager/on_boarding_cubit.dart';
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
        return MaterialPageRoute(
            builder: (_) =>  BlocProvider(
                  create: (context) => OnBoardingCubit(),
                  child: const OnBoardingScreen(),
                ));

      case RouteConstants.signupRoute:
        return MaterialPageRoute(builder: (_) => SigUpView());

      case RouteConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());

      case RouteConstants.restorePasswordRoute:
        return MaterialPageRoute(builder: (_) => RestorePasswordView());

      case RouteConstants.newPasswordRoute:
        return MaterialPageRoute(builder: (_) => NewPasswordView());

      case RouteConstants.emailVerificationRoute:
        return MaterialPageRoute(builder: (_) => const EmailVerificationView());
      case RouteConstants.emailConfirmationRoute:
        return MaterialPageRoute(builder: (_) => const EmailConfirmationView());
      case RouteConstants.homeRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => BnbManagerCubit(),
                  child: const AppBNB(),
                ));
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
