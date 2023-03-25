import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';
import '../../app/l10n/locale_keys.g.dart';
import '../../customwidget/button_custom.dart';
import '../../customwidget/sizedbox_custom.dart';
import '../../customwidget/textformfield_custom.dart';

class SigUpScreen extends StatefulWidget {
  const SigUpScreen({Key? key}) : super(key: key);

  @override
  State<SigUpScreen> createState() => _SigUpScreenState();
}

class _SigUpScreenState extends State<SigUpScreen> {
  final _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppHeightSize.h12, horizontal: AppWidthSize.w20),
            child: ListView(children: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: AppWidthSize.w280),
                child: SvgPicture.asset(
                  ImagePath.iconHome,
                  width: AppWidthSize.w65,
                  height: AppHeightSize.h73,
                ),
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
                prefixIcon: Icon(Icons.visibility_outlined),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              CustomTextFormField(
                fullNameController: _fullNameController,
                text: LocaleKeys.confirmPasswordText.tr(),
                prefixIcon: Icon(Icons.visibility_outlined),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h24,
              ),
              CustomButton(
                onPressed: () {},
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
              ),
              SizedBoxCustom(
                height: AppHeightSize.h116,
              ),
              RichTextCustom(
                  text1: LocaleKeys.signupFooter1Text.tr(),
                  text2: LocaleKeys.signupFooter2Text.tr(),
                  color: ColorManager.primaryMainEnableColor),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              ),
            ])));
  }
}
