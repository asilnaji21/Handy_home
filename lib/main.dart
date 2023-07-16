import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy_home_app/app/locator.dart';
import 'package:handy_home_app/bussiness%20logic/InternetCubit/internet_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/nofificationCubit/notification_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/presentation/resources/background_opearation.dart';

import 'app/app.dart';
import 'data/network/local/local_network.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // Initialize the flutter_background package
  // await FlutterBackground.initialize();

  // // Register the BackgroundService
  // FlutterBackground.registerPeriodicTask(
  //   BackgroundService().task,
  //   taskName: 'my_periodic_task',
  //   interval: Duration(minutes: 1),
  // );

  await SharedPrefController().init();
  setUp();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        // Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('ar'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BnbManagerCubit(),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider(
            create: (context) => EditCubit(),
          ),
          BlocProvider(
            create: (context) => BookedServiceCubit(),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(),
          ),
          BlocProvider(
            create: (context) => NotificationUnReadCubit(),
          ),
        
        ],
        child: MyApp(),
      ),
    ),
  );
}




// login account
//naji.mohammed2001@gmail.com
//123**mmMM  
