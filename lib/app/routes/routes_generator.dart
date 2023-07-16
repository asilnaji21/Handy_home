import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/presentation/view/authentication/email_opt_screen.dart';
import 'package:handy_home_app/presentation/view/authentication/emailconfirmation_view.dart';
import 'package:handy_home_app/presentation/view/authentication/emailverification_view.dart';
import 'package:handy_home_app/presentation/view/authentication/login_view.dart';
import 'package:handy_home_app/presentation/view/bnb/app_bnb.dart';
import 'package:handy_home_app/presentation/view/home/category_screen.dart';
import 'package:handy_home_app/presentation/view/home/most_ordered_screen.dart';
import 'package:handy_home_app/presentation/view/home/order_custom_service_screen.dart';
import 'package:handy_home_app/presentation/view/home/service_details_screen.dart';
import 'package:handy_home_app/presentation/view/home/service_info_screen.dart';
import 'package:handy_home_app/presentation/view/profile/FAQ_screen.dart';
import 'package:handy_home_app/presentation/view/profile/about_the_app_screen.dart';
import 'package:handy_home_app/presentation/view/profile/add_new_email_screen.dart';
import 'package:handy_home_app/presentation/view/profile/addresses_management.dart';
import 'package:handy_home_app/presentation/view/profile/become_service_provider_application_screen.dart';
import 'package:handy_home_app/presentation/view/profile/become_service_provider_info_screen.dart';
import 'package:handy_home_app/presentation/view/profile/call_me_screen.dart';
import 'package:handy_home_app/presentation/view/profile/otp_code_screen.dart';
import 'package:handy_home_app/presentation/view/profile/privicy_polices_screen.dart';
import 'package:handy_home_app/presentation/view/profile/uses_police_screen.dart';
import '../../bussiness logic/onboardingManager/on_boarding_cubit.dart';
import '../../bussiness logic/profileCubit/profile_cubit.dart';
import '../../data/models/service_info_model.dart';
import '../../presentation/view/authentication/newpassword_view.dart';
import '../../presentation/view/authentication/restorepassword_view.dart';
import '../../presentation/view/authentication/signup_view.dart';
import '../../presentation/view/onBoarding/onboarding.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.onBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OnBoardingCubit(),
                  child: const OnBoardingScreen(),
                ));

      case RouteConstants.signupRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: SigUpView(),
                ));

      case RouteConstants.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const LoginView(),
                ));

      case RouteConstants.restorePasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const RestorePasswordView(),
                ));

      case RouteConstants.newPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: NewPasswordView(token: settings.arguments as String),
                ));

      case RouteConstants.emailVerificationRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: EmailVerificationView(
                      email: settings.arguments as String),
                ));
      case RouteConstants.emailConfirmationRoute:
        return MaterialPageRoute(builder: (_) => const EmailConfirmationView());
      case RouteConstants.categoryRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(),
            child: CategoryScreen(categoryId: settings.arguments as int),
          ),
        );
      case RouteConstants.serviceDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    // BlocProvider(
                    //   create: (context) => HomeCubit(),
                    // ),
                    BlocProvider(
                      create: (context) => BookedServiceCubit(),
                    )
                  ],
                  child: ServiceDetailsScreen(
                    serviceEndPoint: settings.arguments as String,
                  ),
                ));
      case RouteConstants.serviceInfoRoute:
        return MaterialPageRoute(
            builder: (_) => ServiceInfoScreen(
                  serviceInfo: settings.arguments as ServiceInfoModel,
                ));
      case RouteConstants.orderCustomServiceRoute:
        return MaterialPageRoute(
            builder: (_) => const OrderCustomServiceScreen());
      case RouteConstants.homeRoute:
        return MaterialPageRoute(
            builder: (_) => const AppBNB(),
            settings: const RouteSettings(name: RouteConstants.homeRoute));
      case RouteConstants.emailOtpRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: EmailOtpScreen(
                    email: settings.arguments as String,
                  ),
                ));

      case RouteConstants.becomeServiceProviderInfoScreen:
        return MaterialPageRoute(
            builder: (_) => const BecomeServiceProviderInfoScreen());
      case RouteConstants.becomeServiceProviderApplicationScreen:
        return MaterialPageRoute(
            builder: (_) => const BecomeServiceProviderApplicationScreen());

      case RouteConstants.addressesManagementScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => DeleteCubit(),
                  ),
                ], child: const AddressesManagementScreen()));
      case RouteConstants.newEmailScreen:
        return MaterialPageRoute(builder: (_) => const NewEmailScreen());
      case RouteConstants.mostAdded:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LatestServiceCubit(),
                  child: MostOrderedScreen(name: settings.arguments as String),
                ));

      case RouteConstants.otpScreen:
        return MaterialPageRoute(
            builder: (_) => OtpScreen(
                  email: settings.arguments as String,
                ));

      case RouteConstants.aboutTheApp:
        return MaterialPageRoute(builder: (_) => const AboutTheAppScreen());
      case RouteConstants.usesPolice:
        return MaterialPageRoute(builder: (_) => const UsersPolicesScreen());
      case RouteConstants.privacyPolice:
        return MaterialPageRoute(builder: (_) => const PrivacyPoliceScreen());
      case RouteConstants.fAQScreen:
        return MaterialPageRoute(builder: (_) => const FAQScreen());
          case RouteConstants.callApp:
        return MaterialPageRoute(builder: (_) => const CallScreen());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
