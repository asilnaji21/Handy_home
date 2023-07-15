import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../../app/routes/navigation_manager.dart';
import '../../../../customwidget/custom_button_with_background_widget.dart';
import '../../../../customwidget/loading_widget.dart';
import '../../../../customwidget/snackbar.dart';
import '../../../../customwidget/textformfield_custom.dart';
import '../../../../data/models/location_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../../home/category_screen.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({
    this.location,
    Key? key,
  }) : super(key: key);
  final LocationModel? location;
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
  void initState() {
    super.initState();
    addressNameController
        .setText(widget.location != null ? widget.location!.addressName : '');
    countryController
        .setText(widget.location != null ? widget.location!.country : '');
    cityController
        .setText(widget.location != null ? widget.location!.city : '');
    buildingNameController
        .setText(widget.location != null ? widget.location!.building : '');
    apartmentNumberController.setText(
        widget.location != null ? widget.location!.apartmentNumber : '');
    mobileNumberController.setText(widget.location != null
        ? widget.location!.phoneNumber.substring(2)
        : '');
  }

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
                      widget.location != null
                          ? 'تعديل عنوان'
                          : 'إضافة عنوان جديد',
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
                      maxLength: 8,
                      controller: mobileNumberController,
                      validator: (value) => value!.isValidPhone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counter: SizedBox(),
                        hintText: 'رقم الهاتف',
                        suffixIcon: SvgPicture.asset(
                          IconPath.mobilePrefixIcon,
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    BlocListener<EditCubit, EditState>(
                      listener: (context, state) {
                        if (state is EditLoadingState) {
                          showLoading(context);
                        } else if (state is EditSuccessState) {
                          context.read<ProfileCubit>().getLocation();
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                          NavigationManager.pop();
                          NavigationManager.pop();
                        } else if (state is EditFailedState) {
                          NavigationManager.pop();
                          NavigationManager.pop();
                          showSnackBar(context,
                              text: state.message,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black);
                        }
                      },
                      child: const SizedBox(
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
              BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is AddLocationLoadingState) {
                    showLoading(context);
                  } else if (state is AddLocationSuccessState) {
                    context.read<ProfileCubit>().getLocation();
                    showSnackBar(context,
                        text: state.message,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    NavigationManager.pop();
                    NavigationManager.pop();
                  } else if (state is AddLocationFailedState) {
                    NavigationManager.pop();
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message,
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  }
                },
                child: CustomButtonWithBackgroundWidget(
                  text: 'حفظ',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      widget.location != null
                          ? context.read<EditCubit>().editLocation(
                                addressName: addressNameController.text,
                                endpoint: widget.location!.detail,
                                country: countryController.text,
                                city: cityController.text,
                                building: buildingNameController.text,
                                apartmentNumber: apartmentNumberController.text,
                                phoneNumber: '05' + mobileNumberController.text,
                              )
                          : context.read<ProfileCubit>().addNewLocation(
                                addressName: addressNameController.text,
                                country: countryController.text,
                                city: cityController.text,
                                building: buildingNameController.text,
                                apartmentNumber: apartmentNumberController.text,
                                phoneNumber: '05' + mobileNumberController.text,
                              );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
