import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../../../customwidget/custom_button_with_background_widget.dart';
import '../../../../customwidget/textformfield_custom.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../../home/category_screen.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  TextEditingController addressNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    addressNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    buildingNameController.dispose();
    apartmentNumberController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Card(
        color: ColorManager.background,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'إضافة عنوان جديد',
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
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    CustomTextFormField(
                        controller: addressNameController,
                        validator: (value) => value!.isNotEmptyField,
                        text: 'اسم العنوان'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        controller: countryController,
                        validator: (value) => value!.isNotEmptyField,
                        text: 'الدولة'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        controller: cityController,
                        validator: (value) => value!.isNotEmptyField,
                        text: 'المدينة'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        controller: buildingNameController,
                        validator: (value) => value!.isNotEmptyField,
                        text: 'اسم البناية'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        controller: apartmentNumberController,
                        validator: (value) => value!.isNotEmptyField,
                        text: 'رقم الشقة'),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: mobileNumberController,
                      validator: (value) => value!.isValidPhone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'رقم الهاتف',
                        suffixIcon: SvgPicture.asset(
                          IconPath.mobilePrefixIcon,
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              CustomButtonWithBackgroundWidget(
                text: 'حفظ',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('object');
                  }
                },
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -3),
                    blurRadius: 10,
                    color: Colors.grey.shade400,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
