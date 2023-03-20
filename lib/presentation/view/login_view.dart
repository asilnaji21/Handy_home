import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../app/l10n/locale_keys.g.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            LocaleKeys.appTitle.tr(),
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontSize: 24,
            ),
          ),
          Text(
            LocaleKeys.appTitle.tr(),
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontWeight: FontWeight.w300, // Regular variant
              fontSize: 24,
            ),
          ),
          Text(
            LocaleKeys.appTitle.tr(),
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontWeight: FontWeight.w800, // Bold variant
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
