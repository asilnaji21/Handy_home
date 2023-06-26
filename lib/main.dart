import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy_home_app/app/locator.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: MyApp(),
    ),
  );
}


// login account
//naji.mohammed2001@gmail.com
//123**mmMM  
