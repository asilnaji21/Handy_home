import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../customwidget/backbutton_custom.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
            child: ListView(children: [
              const BackButtonCstom(),
              SizedBoxCustom(
                height: AppHeightSize.h52,
              ),
              Image.asset(
                ImagePath.undrawVerified,
                width: AppWidthSize.w180,
                height: AppHeightSize.h180,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              HeaderCustom(
                text1: LocaleKeys.emailVerificationText.tr(),
                subText: LocaleKeys.subEmailVerificationText.tr(),
                textAlign: TextAlign.center,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h24,
              ),
              CustomButton(
                onPressed: () {},
                text: Text(LocaleKeys.openEmailText.tr()),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              RichTextCustom(
                  text1: LocaleKeys.passwordRecoveryEmail.tr(),
                  text2: LocaleKeys.pressHereText.tr(),
                  color: ColorManager.brownColor,
                  textDecoration: TextDecoration.none,
                  onPressed: () => NavigationManager.navigationConfiguration
                      .pushNamed(RouteConstants.newPasswordRoute)),
              SizedBoxCustom(
                height: AppHeightSize.h180,
              ),
              RichTextCustom(
                text1: LocaleKeys.rememberPasswordText.tr(),
                text2: LocaleKeys.backToLoginText.tr(),
                color: ColorManager.primaryMainEnableColor,
                onPressed: () => NavigationManager.navigationConfiguration
                    .pushNamed(RouteConstants.loginRoute),
                textDecoration: TextDecoration.none,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              ),
            ])));
  }
}
