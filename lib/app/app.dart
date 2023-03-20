import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/app/routes/routes_generator.dart';

class MyApp extends StatelessWidget {
  MyApp._internal(); //named constructor

  static final _instance = MyApp._internal(); //singlton

  factory MyApp() => _instance; //factory
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.loginRoute,
      onGenerateRoute: RouteGenerator.generateRoutes,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
