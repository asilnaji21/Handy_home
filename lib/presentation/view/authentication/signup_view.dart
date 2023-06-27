import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_state.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/snackbar.dart';
import '../../../customwidget/textformfield_custom.dart';

class SigUpView extends StatefulWidget {
  SigUpView({Key? key}) : super(key: key);

  @override
  State<SigUpView> createState() => _SigUpViewState();
}

class _SigUpViewState extends State<SigUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: AppHeightSize.h12, horizontal: AppWidthSize.w20),
          children: [
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
              controller: _fullNameController,
              text: LocaleKeys.fullNameText.tr(),
              validator: (value) => value!.isValidName,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            CustomTextFormField(
              controller: _emailController,
              validator: (value) => value!.isValidEmail,
              text: LocaleKeys.emailText.tr(),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            CustomTextFormField(
              controller: _passwordController,
              text: LocaleKeys.passwordText.tr(),
              validator: (value) => value!.isValidPassword,
              obscureIconEnable: true,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'هذا الحقل مطلوب';
                } else if (value != _passwordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
              text: LocaleKeys.confirmPasswordText.tr(),
              obscureIconEnable: true,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h24,
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  showSnackBar(context,
                      text: state.message,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                  NavigationManager.goToAndRemove(RouteConstants.emailOtpRoute);
                } else if (state is RegisterFailureState) {
                  NavigationManager.pop();
                  showSnackBar(context,
                      text: state.errorMessage,
                      backgroundColor: Colors.grey,
                      textColor: Colors.black);
                } else if (state is RegisterLoadingState) {
                  showLoading(context);
                }
              },
              child: CustomButtonPrimary(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register(
                          firstName: _fullNameController.text.split(" ")[0],
                          lastName:
                              _fullNameController.text.split(" ").length > 1
                                  ? _fullNameController.text.split(" ")[1]
                                  : _fullNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                  }
                },
                text: Text(LocaleKeys.signupButtonText.tr()),
              ),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h16,
            ),
            RichTextCustom(
                text1: "${LocaleKeys.privacyTerms1Text.tr()}\n",
                text2: LocaleKeys.privacyTerms2Text.tr(),
                color: ColorManager.brownColor,
                textDecoration: TextDecoration.none,
                onPressed: () {}),
            SizedBoxCustom(
              height: AppHeightSize.h116,
            ),
            RichTextCustom(
              text1: LocaleKeys.signupFooter1Text.tr(),
              text2: LocaleKeys.signupFooter2Text.tr(),
              color: ColorManager.primaryMainEnableColor,
              onPressed: () =>
                  NavigationManager.pushNamed(RouteConstants.loginRoute),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h35,
            ),
          ]),
    ));
  }
}
