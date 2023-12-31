import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/data/models/location_model.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../bussiness logic/homeCubit/home_cubit.dart';
import '../../../../customwidget/loading_widget.dart';
import '../../../../customwidget/snackbar.dart';
import '../../../../data/models/service_info_model.dart';
import '../../../../data/models/service_model.dart';
import '../../../resources/style_manager.dart';
import '../../profile/ProfileComponents/add_address_bottom_sheet.dart';
import '../category_screen.dart';

class OrderServiceBottomSheet extends StatefulWidget {
  const OrderServiceBottomSheet({
    required this.service,
    Key? key,
  }) : super(key: key);
  final ServiceModel? service;

  @override
  State<OrderServiceBottomSheet> createState() =>
      _OrderServiceBottomSheetState();
}

class _OrderServiceBottomSheetState extends State<OrderServiceBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int serviceCount = 1;
  LocationModel? selectedLocation;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طلب خدمة',
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
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 30,
                        right: 30),
                    child: ListView(
                      children: [
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
                                  ? DateFormat.yMd('en-IN')
                                      .format(selectedDate!)
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
                        const LabelTextFieldWidget(text: 'العدد من هذه الخدمة'),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        serviceCount++;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                style: StyleManger.headline1(fontSize: 16),
                                controller: TextEditingController(
                                  text: serviceCount.toString(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      if (serviceCount == 1) return;
                                      setState(() {
                                        serviceCount--;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    )))
                          ],
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
                                validator: (value) => value == null ||
                                        value.apartmentNumber.isEmpty
                                    ? 'هذا الحقل مطلوب'
                                    : null,
                                hint: Text(
                                  'اضغط  لاختيار الموقع المناسب',
                                  style:
                                      StyleManger.headline2(color: Colors.grey),
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
                                builder: (context) =>
                                    const AddAddressBottomSheet(),
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
                        const LabelTextFieldWidget(text: 'تفاصيل إضافية'),
                        TextFormField(
                          maxLines: 54,
                          minLines: 5,
                          validator: (value) => value!.isNotEmptyField,
                          decoration: const InputDecoration(
                              hintText:
                                  'اي تفاصيل اضافية تساعدنا في فهم احتياجكم لهذه الخدمة'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 8,
                )
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                children: [
                  BlocListener<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if (state is OrderFixedServiceSuccessState) {
                        NavigationManager.goToAndRemove(
                          RouteConstants.serviceInfoRoute,
                          argument: ServiceInfoModel(
                            isCustom: false,
                            description: '',
                            serviceName: widget.service?.name ?? '',
                            date: DateFormat.yMd('en-IN').format(selectedDate!),
                            time: selectedTime!.format(context),
                            count: serviceCount.toString(),
                            totalPrice: (widget.service!.priceTo * serviceCount)
                                .toString(),
                          ),
                        );
                        showSnackBar(context,
                            text: 'تم طلب الخدمة بنجاح',
                            backgroundColor: Colors.green,
                            textColor: Colors.white);
                      } else if (state is OrderFixedServiceFailedState) {
                        NavigationManager.pop();
                        NavigationManager.pop();
                        showSnackBar(context,
                            text: state.message,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black);
                      } else if (state is OrderFixedServiceLoadingState) {
                        showLoading(context);
                      }
                    },
                    child: Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<HomeCubit>().orderFixedService(
                                quantity: serviceCount,
                                totalPrice:
                                    widget.service?.priceTo ?? 0 * serviceCount,
                                date: DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!),
                                time:
                                    selectedTime!.format(context).split(" ")[0],
                                service: widget.service!.id!,
                                location:selectedLocation!.id
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(double.infinity, 56)),
                        child: const Text('تأكيد الطلب'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: '80 شيكل',
                      style: StyleManger.headline1(
                          color: ColorManager.primaryMainEnableColor,
                          fontSize: 16),
                      decoration:
                          const InputDecoration(fillColor: Color(0xFFEBF1F0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabelTextFieldWidget extends StatelessWidget {
  const LabelTextFieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: StyleManger.headline1(fontSize: 14),
      ),
    );
  }
}
