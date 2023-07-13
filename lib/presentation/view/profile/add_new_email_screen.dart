import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';

import '../../../customwidget/button_custom.dart';
import '../../../customwidget/header_custom.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../../customwidget/snackbar.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';
import '../home/category_screen.dart';

class NewEmailScreen extends StatefulWidget {
  const NewEmailScreen({Key? key}) : super(key: key);

  @override
  State<NewEmailScreen> createState() => _NewEmailScreenState();
}

class _NewEmailScreenState extends State<NewEmailScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormFieldState> formFieldKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const CustomHeaderWidget(
              title: 'تغيير البريد الالكتروني',
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBoxCustom(
                    height: AppHeightSize.h52,
                  ),
                  Image.asset(
                    ImagePath.codeVerificationImage,
                    width: AppWidthSize.w180,
                    height: AppHeightSize.h180,
                  ),
                  SizedBoxCustom(
                    height: AppHeightSize.h16,
                  ),
                  const HeaderCustom(
                    text1: 'اضافة البريد الالكتروني الجديد',
                    subText: 'قم بكتابة البريد الالكتروني الجديد لاعتماده!',
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxCustom(
                    height: AppHeightSize.h18,
                  ),
                  CustomTextFormField(
                    fieldKey: formFieldKey,
                    controller: emailController,
                    text: LocaleKeys.emailText.tr(),
                    validator: (value) => value!.isValidEmail,
                  ),
                  SizedBoxCustom(
                    height: AppHeightSize.h18,
                  ),
                  BlocListener<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ChangeEmailLoadingState) {
                        showLoading(context);
                      } else if (state is ChangeEmailSuccessState) {
                        showSnackBar(context,
                            text: state.message,
                            backgroundColor: Colors.green,
                            textColor: Colors.white);
                        NavigationManager.pushNamed(RouteConstants.otpScreen,
                            arguments: emailController.text);
                      } else if (state is ChangeEmailFailedState) {
                        NavigationManager.pop();
                        showSnackBar(context,
                            text: state.message,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black);
                      }
                    },
                    child: CustomButtonPrimary(
                      onPressed: () {
                        if (formFieldKey.currentState!.validate()) {
                          context
                              .read<ProfileCubit>()
                              .changeEmail(email: emailController.text);
                        }
                      },
                      text: Text('تأكيد'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
