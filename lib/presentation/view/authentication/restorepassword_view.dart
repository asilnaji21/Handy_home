import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/l10n/locale_keys.g.dart';
import 'package:handy_home_app/customwidget/backbutton_custom.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/richtext_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class RestorPasswordView extends StatelessWidget {
  RestorPasswordView({Key? key}) : super(key: key);
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
        child: ListView(
          children: [
            const BackButtonCstom(),
            SizedBoxCustom(
              height: AppHeightSize.h52,
            ),
            Image.asset(
              ImagePath.resetPasswordImage,
              width: AppWidthSize.w180,
              height: AppHeightSize.h180,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            HeaderCustom(
              text1: LocaleKeys.restoreText.tr() + LocaleKeys.passwordText.tr(),
              subText: LocaleKeys.subRestorePasswordText.tr(),
              textAlign: TextAlign.center,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h9,
            ),
            CustomTextFormField(
              fullNameController: _emailController,
              text: LocaleKeys.emailText.tr(),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h18,
            ),
            CustomButton(
              onPressed: () => NavigationManager.navigationConfiguration
                  .pushNamed(RouteConstants.emailVerificationRoute),
              text: Text(LocaleKeys.restoreText.tr()),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h180,
            ),
            RichTextCustom(
                text1: LocaleKeys.rememberPasswordText.tr(),
                text2: LocaleKeys.backToLoginText.tr(),
                color: ColorManager.primaryMainEnableColor,
                onPressed: () => NavigationManager.navigationConfiguration
                    .pushNamed(RouteConstants.loginRoute)),
            SizedBoxCustom(
              height: AppHeightSize.h35,
            )
          ],
        ),
      ),
    );
  }
}
