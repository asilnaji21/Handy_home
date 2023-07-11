import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/data/models/service_info_model.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

class ServiceInfoScreen extends StatelessWidget {
  const ServiceInfoScreen({required this.serviceInfo, Key? key})
      : super(key: key);
  final ServiceInfoModel serviceInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagePath.doneImage),
            const SizedBox(
              height: 16,
            ),
            Text(
              'لقد تم طلب الخدمة بنجاح',
              style: StyleManger.headline1(fontSize: 22),
            ),
            const SizedBox(
              height: 16,
            ),
            RowInfoWidget(label: 'اسم الخدمة:', info: serviceInfo.serviceName),
            RowInfoWidget(label: 'التاريخ:', info: serviceInfo.date),
            RowInfoWidget(label: 'الوقت:', info: serviceInfo.time),
            Visibility(
                visible: !(serviceInfo.isCustom),
                child: RowInfoWidget(
                    label: 'العدد من هذه الخدمة:', info: serviceInfo.count)),
            RowInfoWidget(
                label: (serviceInfo.isCustom) ? 'التفاصيل:' : 'التكلفة الكلية:',
                info: (serviceInfo.isCustom)
                    ? 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.'
                    : serviceInfo.totalPrice),
            const RowInfoWidget(
              label: 'حالة الطلب:',
              orderStatusWidget: OrderStatusWidget(
                text: 'قيد المراجعة',
                backgroundColor: ColorManager.orangeLightColor,
                textColor: ColorManager.orangeDarkColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BnbManagerCubit>().onSelectItem(2);
                NavigationManager.goToAndRemove(RouteConstants.homeRoute);
              },
              child: const Text('الذهاب لصفحة الطلبات'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                NavigationManager.goToAndRemove(RouteConstants.homeRoute);
              },
              child: const Text(
                'العودة لصغحة الخدمات',
                style: TextStyle(
                  color: ColorManager.primaryMainEnableColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50)),
            )
          ],
        ),
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    this.alignment = Alignment.centerRight,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final AlignmentGeometry alignment;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        height: 23,
        width: 84,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: backgroundColor),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class RowInfoWidget extends StatelessWidget {
  const RowInfoWidget({
    required this.label,
    this.info,
    this.orderStatusWidget,
    Key? key,
  }) : super(key: key);
  final String label;
  final String? info;
  final Widget? orderStatusWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: StyleManger.headline1(fontSize: 15),
            ),
          ),
          Expanded(
            child: orderStatusWidget != null
                ? orderStatusWidget!
                : Text(
                    info!,
                    textAlign: TextAlign.start,
                    style: StyleManger.headline2(fontSize: 15),
                  ),
          ),
        ],
      ),
    );
  }
}
