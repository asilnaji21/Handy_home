import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';
import 'package:pinput/pinput.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../../customwidget/backbutton_custom.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/snackbar.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  late final TextEditingController pinController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
            child: ListView(children: [
              const BackButtonCustom(),
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
                height: AppHeightSize.h16,
              ),
              Form(
                key: formKey,
                child: Pinput(
                  controller: pinController,
                  validator: (value) => value!.isValidOtp,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  autofillHints: const [AutofillHints.oneTimeCode],
                  errorPinTheme: PinTheme(
                      height: 55,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: ColorManager.redDarkColor))),
                  focusedPinTheme: PinTheme(
                      height: 55,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: ColorManager.primaryMainEnableColor))),
                  length: 5,
                  toolbarEnabled: false,
                  defaultPinTheme: PinTheme(
                    height: 55,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h24,
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyResetPasswordCodeState &&
                      state.verifyResetPasswordCodeStatus ==
                          VerifyResetPasswordCodeStatus.success) {
                    showSnackBar(context,
                        text: state.data.detail,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    NavigationManager.pushNamed(RouteConstants.newPasswordRoute,
                        arguments: state.data.token);
                  } else if (state is VerifyResetPasswordCodeState &&
                      state.verifyResetPasswordCodeStatus ==
                          VerifyResetPasswordCodeStatus.failed) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.data ?? '',
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  } else if (state is VerifyResetPasswordCodeState &&
                      state.verifyResetPasswordCodeStatus ==
                          VerifyResetPasswordCodeStatus.loading) {
                    showLoading(context);
                  }
                },
                child: CustomButtonPrimary(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<AuthCubit>()
                          .verifyResetPasswordCode(code: pinController.text);
                    }
                  },
                  text: Text(LocaleKeys.openEmailText.tr()),
                ),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              RichTextCustom(
                  text1: LocaleKeys.passwordRecoveryEmail.tr(),
                  text2: LocaleKeys.pressHereText.tr(),
                  color: ColorManager.brownColor,
                  textDecoration: TextDecoration.none,
                  onPressed: () {
                    //TODO add reset code request
                  }),
              SizedBoxCustom(
                height: AppHeightSize.h180,
              ),
              RichTextCustom(
                text1: LocaleKeys.rememberPasswordText.tr(),
                text2: LocaleKeys.backToLoginText.tr(),
                color: ColorManager.primaryMainEnableColor,
                onPressed: () =>
                    NavigationManager.pushNamed(RouteConstants.loginRoute),
                textDecoration: TextDecoration.none,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              ),
            ])));
  }
}
