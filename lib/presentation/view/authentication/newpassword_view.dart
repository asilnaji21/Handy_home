import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/l10n/locale_keys.g.dart';
import 'package:handy_home_app/customwidget/header_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/authCubit/auth_cubit.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../../customwidget/backbutton_custom.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/snackbar.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/values_manager.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({
    Key? key,
    required this.token,
  }) : super(key: key);
  final String token;
  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const BackButtonCustom(),
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
                  if (state is ResetNewPasswordState &&
                      state.resetNewPasswordStatus ==
                          ResetNewPasswordStatus.success) {
                    print(state.message);
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    NavigationManager.goToAndRemove(RouteConstants.loginRoute);
                  } else if (state is ResetNewPasswordState &&
                      state.resetNewPasswordStatus ==
                          ResetNewPasswordStatus.failed) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  } else if (state is ResetNewPasswordState &&
                      state.resetNewPasswordStatus ==
                          ResetNewPasswordStatus.loading) {
                    showLoading(context);
                  }
                },
                child: CustomButtonPrimary(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().resetNewPassword(
                          token: widget.token,
                          newPassword: _passwordController.text);
                    }
                  },
                  text: Text(LocaleKeys.saveText.tr()),
                ),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              )
            ],
          ),
        ),
      ),
    );
  }
}
