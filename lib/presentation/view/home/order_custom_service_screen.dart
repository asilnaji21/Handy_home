import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:skeletons/skeletons.dart';

import '../../../bussiness logic/profileCubit/profile_cubit.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/snackbar.dart';
import '../../../data/models/location_model.dart';
import '../../../data/models/service_info_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/style_manager.dart';
import '../profile/ProfileComponents/add_address_bottom_sheet.dart';
import 'HomeComponents/order_service_bottom_sheet.dart';
import 'category_screen.dart';

class OrderCustomServiceScreen extends StatefulWidget {
  const OrderCustomServiceScreen({Key? key}) : super(key: key);

  @override
  State<OrderCustomServiceScreen> createState() =>
      _OrderCustomServiceScreenState();
}

class _OrderCustomServiceScreenState extends State<OrderCustomServiceScreen> {
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedCategory;
  bool isScroll = false;

  LocationModel? selectedLocation;

  TextEditingController detailsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getLocation();
    scrollController.addListener(() {
      setState(() {
        isScroll = scrollController.offset > 0;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: CustomHeaderWidget(
                    title: 'طلب خدمة مخصصة',
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    const LabelTextFieldWidget(text: 'نوع الخدمة'),
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
                        'اضغط لاختيار نوع الخدمة',
                        style: StyleManger.headline2(color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.expand_more_outlined,
                        size: 30,
                      ),
                    ),
                    const LabelTextFieldWidget(text: 'التاريخ'),
                    TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (date == null) return;
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      validator: (value) => value!.isNotEmptyField,
                      controller: TextEditingController(
                          text: selectedDate != null
                              ? DateFormat.yMd('en-IN').format(selectedDate!)
                              : null),
                      decoration: const InputDecoration(
                        hintText: 'يوم - شهر - سنة',
                        suffixIcon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const LabelTextFieldWidget(text: 'الوقت'),
                    TextFormField(
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (time == null) return;
                        setState(() {
                          selectedTime = time;
                        });
                      },
                      validator: (value) => value!.isNotEmptyField,
                      controller: TextEditingController(
                          text: selectedTime != null
                              ? selectedTime!.format(context)
                              : null),
                      decoration: const InputDecoration(
                        hintText: 'اضغط لاختيار الوقت المناسب',
                        suffixIcon: Icon(
                          Icons.schedule_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const LabelTextFieldWidget(text: 'تفاصيل دقيقة عن الخدمة'),
                    TextFormField(
                      controller: detailsController,
                      maxLines: 54,
                      minLines: 5,
                      validator: (value) => value!.isNotEmptyField,
                      decoration: const InputDecoration(
                          hintText:
                              'اي تفاصيل اضافية تساعدنا في فهم احتياجكم لهذه الخدمة'),
                    ),
                    const LabelTextFieldWidget(text: 'الموقع الجغرافي'),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is LocationLoadingState) {
                          return SkeletonItem(
                              child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ));
                        }
                        if (state is LocationSuccessState) {
                          if (state.locations.isEmpty) {
                            return TextFormField(
                              enabled: false,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'اضف عنوان جديد'
                                      : null,
                              decoration: const InputDecoration(
                                  hintText:
                                      'اضف عنوان جديد ,لا يوجد عناوين مضافة',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: ColorManager.redDarkColor),
                                  errorStyle: TextStyle(
                                      height: 0.8,
                                      fontWeight: FontWeight.normal)),
                            );
                          }
                          return DropdownButtonFormField<LocationModel>(
                            items: state.locations
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.addressName),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  selectedLocation = value;
                                }
                              });
                            },
                            validator: (value) =>
                                value == null || value.apartmentNumber.isEmpty
                                    ? 'هذا الحقل مطلوب'
                                    : null,
                            hint: Text(
                              'اضغط  لاختيار الموقع المناسب',
                              style: StyleManger.headline2(color: Colors.grey),
                            ),
                            icon: const Icon(
                              Icons.expand_more_outlined,
                              size: 30,
                            ),
                          );
                        } else {
                          return const Text('something went wrong');
                        }
                      },
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.zero),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            clipBehavior: Clip.antiAlias,
                            context: context,
                            builder: (context) => const AddAddressBottomSheet(),
                          );
                        },
                        child: const Text(
                          '+ اضافة عنوان جديد',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is OrderCustomServiceLoadingState) {
            showLoading(context);
          } else if (state is OrderCustomServiceSuccessState) {
            showSnackBar(context,
                text: 'تم طلب الخدمة بنجاح',
                backgroundColor: Colors.green,
                textColor: Colors.white);
            NavigationManager.goToAndRemove(
              RouteConstants.serviceInfoRoute,
              argument: ServiceInfoModel(
                isCustom: true,
                description: state.customServiceModel.description,
                serviceName: 'خدمة مخصصة',
                date: DateFormat.yMd('en-IN').format(selectedDate!),
                time: selectedTime!.format(context),
                count: '1',
                totalPrice: '',
              ),
            );
          }
          if (state is OrderCustomServiceFailedState) {
            showSnackBar(context,
                text: state.message,
                backgroundColor: Colors.grey,
                textColor: Colors.black);
          }
        },
        child: CustomButtonWithBackgroundWidget(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<HomeCubit>().orderCustomService(
                    name: 'خدمة مخصصة',
                    description: detailsController.text,
                    date: DateFormat('yyyy-MM-dd').format(selectedDate!),
                    time: selectedTime!.format(context).split(" ")[0],
                    category: selectedCategory!,
                    location: selectedLocation!.id,
                  );
            }
          },
          text: 'طلب الخدمة',
        ),
      ),
    );
  }
}

List<String> servicesType = [
  'النجارة',
  'الكهرباء',
  'السباكة',
  'التنظيف',
  'صيانة الشبكات',
  'صيانة الحواسيب',
];
