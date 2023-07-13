import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/authCubit/auth_cubit.dart';
import '../../../bussiness logic/bnbManager/bnb_manager_cubit.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/snackbar.dart';
import '../home/category_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.email, Key? key}) : super(key: key);
  final String email;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CustomHeaderWidget(
              title: 'تغيير البريد الالكتروني',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'التحقق من البريد الالكتروني',
                      style: StyleManger.headline1(
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'لقد قمنا بارسال كود تفعيل الى بريدك الالكتروني٬ يرجى ادخال الكود المرسل',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
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
                                border: Border.all(
                                    color: ColorManager.redDarkColor))),
                        focusedPinTheme: PinTheme(
                            height: 55,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color:
                                        ColorManager.primaryMainEnableColor))),
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
                    const SizedBox(
                      height: 16,
                    ),
                    BlocListener<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is VerifyNewEmailLoadingState) {
                          showLoading(context);
                        } else if (state is VerifyNewEmailSuccessState) {
                          context.read<ProfileCubit>().getUserInfo();
                          NavigationManager.popUntil(RouteConstants.homeRoute);
                          context.read<BnbManagerCubit>().onSelectItem(4);
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                        } else if (state is VerifyNewEmailFailedState) {
                          NavigationManager.pop();
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black);
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<ProfileCubit>()
                                .verifyNewEmail(code: pinController.text);
                          }
                        },
                        child: const Text(
                          'تأكيد',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 54)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocListener<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is ChangeEmailLoadingState) {
                          showLoading(context);
                        } else if (state is ChangeEmailSuccessState) {
                          NavigationManager.pop();
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                        } else if (state is ChangeEmailFailedState) {
                          NavigationManager.pop();
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black);
                        }
                      },
                      child: RichTextCustom(
                          text1: 'لم تستلم بريد التفعيل؟ ',
                          text2: 'اضغط هنا',
                          color: ColorManager.brownColor,
                          onPressed: () {
                            context
                                .read<ProfileCubit>()
                                .changeEmail(email: widget.email);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
