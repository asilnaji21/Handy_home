import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/customwidget/textformfield_custom.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../../../customwidget/custom_button_with_background_widget.dart';
import '../../../../customwidget/loading_widget.dart';
import '../../../../customwidget/snackbar.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../../home/category_screen.dart';

Future<dynamic> personalInfoBottomSheet(
  BuildContext context,
) {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  GlobalKey<FormState> fieldKey = GlobalKey<FormState>();
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    context: context,
    backgroundColor: ColorManager.background,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: fieldKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تعديل البيانات الشخصية',
                      style: StyleManger.headline1(fontSize: 22),
                    ),
                    const CardForIconWidget(
                        icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (value) => value!.isNotEmptyField,
                      controller: firstNameController,
                      text: 'First name',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      validator: (value) => value!.isNotEmptyField,
                      controller: lastNameController,
                      text: 'last name',
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is EditPersonalInfoLoadingState) {
                    showLoading(context);
                  } else if (state is EditPersonalInfoSuccessState) {
                    NavigationManager.pop();
                    NavigationManager.pop();
                    context.read<ProfileCubit>().getUserInfo();
                    showSnackBar(context,
                        text: state.message,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                  } else if (state is EditPersonalInfoFailedState) {
                    NavigationManager.pop();
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message,
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  }
                },
                child: CustomButtonWithBackgroundWidget(
                    onPressed: () {
                      if (fieldKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<ProfileCubit>().editPersonalInfo(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                            );
                      }
                    },
                    text: 'حفظ'),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
