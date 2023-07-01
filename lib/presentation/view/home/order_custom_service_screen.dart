import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';

import '../../resources/style_manager.dart';
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
  bool isScroll = false;
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
                        print(value);
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
                      maxLines: 54,
                      minLines: 5,
                      validator: (value) => value!.isNotEmptyField,
                      decoration: const InputDecoration(
                          hintText:
                              'اي تفاصيل اضافية تساعدنا في فهم احتياجكم لهذه الخدمة'),
                    ),
                    const LabelTextFieldWidget(text: 'الموقع الجغرافي'),
                    TextFormField(
                      validator: (value) => value!.isNotEmptyField,
                      decoration: const InputDecoration(
                        hintText: 'اضغط لاختيار الموقع المناسب',
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.zero),
                        onPressed: () {},
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
      bottomNavigationBar: CustomButtonWithBackgroundWidget(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            NavigationManager.goToAndRemove(
              RouteConstants.serviceInfoRoute,
              argument: true,
            );
          }
        },
        text: 'طلب الخدمة',
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
