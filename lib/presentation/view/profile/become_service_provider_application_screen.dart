import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';
import 'package:handy_home_app/customwidget/textformfield_custom.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/snackbar.dart';
import '../../resources/assets_manager.dart';
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
  int? selectedCategory;

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
                    TextFormField(
                      controller: phoneController,
                      validator: (value) => value!.isValidPhone,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      decoration: InputDecoration(
                        counter: SizedBox(),
                        hintText: 'رقم الاتصال',
                        suffixIcon: SvgPicture.asset(
                          IconPath.mobilePrefixIcon,
                          fit: BoxFit.none,
                        ),
                      ),
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
                          if (value != null) {
                            selectedCategory = servicesType.indexOf(value) + 1;
                          }
                          print(selectedCategory);
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
                      validator: (value) => value!.isValidNumber,
                      keyboardType: TextInputType.number,
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
                      validator: (value) => value!.isNotEmptyField,
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
      bottomNavigationBar: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is BecomeServiceProviderLoadingState) {
            showLoading(context);
          } else if (state is BecomeServiceProviderSuccessState) {
            context.read<ProfileCubit>().getUserInfo();
            showSnackBar(context,
                text: 'تم طلب ارسال الطلب بنجاح',
                backgroundColor: Colors.green,
                textColor: Colors.white);
            NavigationManager.popUntil(RouteConstants.homeRoute);
            context.read<BnbManagerCubit>().onSelectItem(4);
          } else if (state is BecomeServiceProviderFailedState) {
            showSnackBar(context,
                text: state.message,
                backgroundColor: Colors.grey,
                textColor: Colors.black);
          }
        },
        child: CustomButtonWithBackgroundWidget(
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
              context.read<ProfileCubit>().becomeServiceProvider(
                    name: fullNameController.text,
                    phone: phoneController.text,
                    location: addressController.text,
                    yearExperience: int.parse(experienceYearsController.text),
                    summaryExperience: experienceDescriptionController.text,
                    additional: anotherDetailsController.text,
                    category: selectedCategory!,
                  );
            }
          },
        ),
      ),
    );
  }
}
