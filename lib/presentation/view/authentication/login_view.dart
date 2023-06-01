import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/customwidget/sizedbox_custom.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';

import '../../../app/l10n/locale_keys.g.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/header_custom.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppHeightSize.h12, horizontal: AppWidthSize.w20),
      child: ListView(
        children: [
          SvgPicture.asset(
            ImagePath.iconHome,
            width: AppWidthSize.w65,
            height: AppHeightSize.h73,
            alignment: AlignmentDirectional.topStart,
          ),
          HeaderCustom(
            text1: LocaleKeys.loginText.tr(),
            subText: LocaleKeys.subLoginText.tr(),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBoxCustom(
            height: AppHeightSize.h40,
          ),
          CustomTextFormField(
            fullNameController: _emailController,
            text: LocaleKeys.emailText.tr(),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h16,
          ),
          CustomTextFormField(
            fullNameController: _emailController,
            text: LocaleKeys.passwordText.tr(),
            suffixIcon: const Icon(Icons.visibility_outlined),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h8,
          ),
          TextButton(
            onPressed: () => NavigationManager.pushNamed(
                RouteConstants.restorePasswordRoute),
            child: Text(
              LocaleKeys.forgetPasswordText.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(decoration: TextDecoration.underline),
            ),
            style: const ButtonStyle(alignment: AlignmentDirectional.topStart),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          CustomButtonPrimary(
            onPressed: () {
              NavigationManager.pushNamedReplacement(RouteConstants.homeRoute);
            },
            text: Text(LocaleKeys.loginText.tr()),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h261,
          ),
          RichTextCustom(
              text1: LocaleKeys.loginFooter1Text.tr(),
              text2: LocaleKeys.loginFooter2Text.tr(),
              color: ColorManager.primaryMainEnableColor,
              onPressed: () =>
                  NavigationManager.pushNamed(RouteConstants.signupRoute)),
          SizedBoxCustom(
            height: AppHeightSize.h35,
          )
        ],
      ),
    ));
  }
}
