import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/l10n/locale_keys.g.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import '../../../customwidget/backbutton_custom.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/values_manager.dart';

class NewPasswordView extends StatelessWidget {
  NewPasswordView({Key? key}) : super(key: key);
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
              ImagePath.newPasswordImage,
              width: AppWidthSize.w180,
              height: AppHeightSize.h180,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            HeaderCustom(
              text1: LocaleKeys.newPasswordText.tr(),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: LocaleKeys.subNewPassword1Text.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: LocaleKeys.subNewPassword2Text.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h9,
            ),
            CustomTextFormField(
              fullNameController: _emailController,
              text: LocaleKeys.passwordText.tr(),
              suffixIcon: const Icon(Icons.visibility_outlined),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            CustomTextFormField(
              fullNameController: _emailController,
              text: LocaleKeys.confirmPasswordText.tr(),
              suffixIcon: const Icon(Icons.visibility_outlined),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h24,
            ),
            CustomButtonPrimary(
              onPressed: () {},
              text: Text(LocaleKeys.saveText.tr()),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h35,
            )
          ],
        ),
      ),
    );
  }
}
