import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/l10n/locale_keys.g.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/customwidget/backbutton_custom.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/richtext_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/snackbar.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class RestorePasswordView extends StatefulWidget {
  const RestorePasswordView({Key? key}) : super(key: key);

  @override
  State<RestorePasswordView> createState() => _RestorePasswordViewState();
}

class _RestorePasswordViewState extends State<RestorePasswordView> {
  final _emailController = TextEditingController();

  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
        child: ListView(
          children: [
            const BackButtonCustom(),
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
              fieldKey: _formFieldKey,
              controller: _emailController,
              text: LocaleKeys.emailText.tr(),
              validator: (value) => value!.isValidEmail,
            ),
            SizedBoxCustom(
              height: AppHeightSize.h18,
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SendPasswordResetCodeState &&
                    state.sendResetCodeStatus ==
                        SendResetCodeStatus.sendCodeSuccess) {
                  NavigationManager.pop();
                  showSnackBar(context,
                      text: state.message ?? '',
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                  NavigationManager.pushNamed(
                      RouteConstants.emailVerificationRoute,
                      arguments: _emailController.text);
                } else if (state is SendPasswordResetCodeState &&
                    state.sendResetCodeStatus ==
                        SendResetCodeStatus.sendCodeFailed) {
                  NavigationManager.pop();
                  showSnackBar(context,
                      text: state.message ?? '',
                      backgroundColor: Colors.grey,
                      textColor: Colors.black);
                } else if (state is SendPasswordResetCodeState &&
                    state.sendResetCodeStatus ==
                        SendResetCodeStatus.sendCodeLoading) {
                  showLoading(context);
                }
              },
              child: CustomButtonPrimary(
                onPressed: () {
                  if (_formFieldKey.currentState!.validate()) {
                    context
                        .read<AuthCubit>()
                        .sendResetPasswordCode(email: _emailController.text);
                  }
                },
                text: Text(LocaleKeys.restoreText.tr()),
              ),
            ),
            SizedBoxCustom(
              height: AppHeightSize.h180,
            ),
            RichTextCustom(
                text1: LocaleKeys.rememberPasswordText.tr(),
                text2: LocaleKeys.backToLoginText.tr(),
                color: ColorManager.primaryMainEnableColor,
                onPressed: () =>
                    NavigationManager.pushNamed(RouteConstants.loginRoute)),
            SizedBoxCustom(
              height: AppHeightSize.h35,
            )
          ],
        ),
      ),
    );
  }
}
