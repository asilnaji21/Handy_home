import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../bussiness logic/authCubit/auth_cubit.dart';
import '../home/category_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {
      // required this.email
      // ,
      Key? key})
      : super(key: key);
  // final String email;
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
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<AuthCubit>()
                              .verifyCode(code: pinController.text);
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
                    const SizedBox(
                      height: 16,
                    ),
                    RichTextCustom(
                        text1: 'لم تستلم بريد التفعيل؟ ',
                        text2: 'اضغط هنا',
                        color: ColorManager.brownColor,
                        onPressed: () {}),
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
