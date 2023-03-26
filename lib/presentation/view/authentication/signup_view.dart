import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/textformfield_custom.dart';

class SigUpView extends StatelessWidget {
  SigUpView({Key? key}) : super(key: key);

  final _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppHeightSize.h12, horizontal: AppWidthSize.w20),
            child: ListView(children: [
              SvgPicture.asset(
                ImagePath.iconHome,
                width: AppWidthSize.w65,
                height: AppHeightSize.h73,
                alignment: AlignmentDirectional.topStart,
              ),
              HeaderCustom(
                text1: LocaleKeys.newUserText.tr(),
                subText: LocaleKeys.subSignupText.tr(),
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              SizedBoxCustom(height: AppHeightSize.h40),
              CustomTextFormField(
                fullNameController: _fullNameController,
                text: LocaleKeys.fullNameText.tr(),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              CustomTextFormField(
                fullNameController: _fullNameController,
                text: LocaleKeys.emailText.tr(),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              CustomTextFormField(
                fullNameController: _fullNameController,
                text: LocaleKeys.passwordText.tr(),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              CustomTextFormField(
                fullNameController: _fullNameController,
                text: LocaleKeys.confirmPasswordText.tr(),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h24,
              ),
              CustomButton(
                onPressed: () => NavigationManager.navigationConfiguration
                    .pushNamed(RouteConstants.emailConfirmationRoute),
                text: Text(LocaleKeys.signupButtonText.tr()),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              RichTextCustom(
                  text1: "${LocaleKeys.privacyTerms1Text.tr()}\n",
                  text2: LocaleKeys.privacyTerms2Text.tr(),
                  color: ColorManager.brownColor,
                  textDecoration: TextDecoration.none,
                  onPressed: () => NavigationManager.navigationConfiguration
                      .pushNamed(RouteConstants.loginRoute)),
              SizedBoxCustom(
                height: AppHeightSize.h116,
              ),
              RichTextCustom(
                text1: LocaleKeys.signupFooter1Text.tr(),
                text2: LocaleKeys.signupFooter2Text.tr(),
                color: ColorManager.primaryMainEnableColor,
                onPressed: () => NavigationManager.navigationConfiguration
                    .pushNamed(RouteConstants.loginRoute),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              ),
            ])));
  }
}
