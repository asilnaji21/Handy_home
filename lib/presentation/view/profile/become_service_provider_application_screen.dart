import 'package:flutter/material.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';
import 'package:handy_home_app/customwidget/textformfield_custom.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../home/category_screen.dart';
import '../home/order_custom_service_screen.dart';

class BecomeServiceProviderApplicationScreen extends StatefulWidget {
  const BecomeServiceProviderApplicationScreen({Key? key}) : super(key: key);

  @override
  State<BecomeServiceProviderApplicationScreen> createState() =>
      _BecomeServiceProviderApplicationScreenState();
}

class _BecomeServiceProviderApplicationScreenState
    extends State<BecomeServiceProviderApplicationScreen> {
  bool isScroll = false;
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController experienceYearsController = TextEditingController();
  TextEditingController experienceDescriptionController =
      TextEditingController();
  TextEditingController anotherDetailsController = TextEditingController();
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        isScroll = scrollController.offset > 0;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    experienceYearsController.dispose();
    experienceDescriptionController.dispose();
    anotherDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                color: isScroll ? Colors.white : Colors.transparent,
                child: const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: CustomHeaderWidget(
                    title: 'قم بتعبئة النموذج التالي',
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 31, vertical: 10),
                  children: [
                    Text(
                      'البيانات الشخصية',
                      style: StyleManger.headline1(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: fullNameController,
                      validator: (value) => value!.isValidName,
                      text: 'الاسم الكامل',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        controller: emailController,
                        validator: (value) => value!.isValidEmail,
                        keyboardType: TextInputType.emailAddress,
                        text: 'عنوان البريد الالكتروني'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      validator: (value) => value!.isValidPhone,
                      controller: phoneController,
                      text: 'رقم الاتصال',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: addressController,
                      validator: (value) => value!.isNotEmptyField,
                      text: 'العنوان الكامل',
                      minLines: 2,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'بيانات العمل',
                      style: StyleManger.headline1(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButtonFormField<String>(
                      items: servicesType
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? 'هذا الحقل مطلوب'
                          : null,
                      hint: Text(
                        'فئة الخدمة',
                        style: StyleManger.headline2(color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.expand_more_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: experienceYearsController,
                      validator: (value) => value!.isNotEmptyField,
                      text: 'سنوات الخبرة',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: experienceDescriptionController,
                      text: 'وصف موجز لخبرتك',
                      validator: (value) => value!.isNotEmptyField,
                      minLines: 2,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: anotherDetailsController,
                      text: 'تفاصيل اضافية',
                      minLines: 3,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButtonWithBackgroundWidget(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -3),
            blurRadius: 10,
            color: Colors.grey.shade400,
          )
        ],
        text: 'تقديم الطلب!',
        onPressed: () {
          if (formKey.currentState!.validate()) {
            print('object');
          }
        },
      ),
    );
  }
}
