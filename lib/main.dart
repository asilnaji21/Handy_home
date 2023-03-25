import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [
      // Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/l10n',
    fallbackLocale: const Locale('ar'),
    child: MyApp(),
  ));
}
