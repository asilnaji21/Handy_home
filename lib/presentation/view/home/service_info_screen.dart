import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

class ServiceInfoScreen extends StatelessWidget {
  const ServiceInfoScreen({Key? key}) : super(key: key);

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
            const RowInfoWidget(label: 'اسم الخدمة:', info: 'تركيب حنفية مياه'),
            const RowInfoWidget(label: 'التاريخ:', info: '10 مايو 2023'),
            const RowInfoWidget(label: 'الوقت:', info: '12:45 مساء'),
            const RowInfoWidget(label: 'العدد من هذه الخدمة:', info: '3'),
            const RowInfoWidget(label: 'التكلفة الكلية:', info: '80 شيكل'),
            const RowInfoWidget(
              label: 'حالة الطلب:',
              orderStatusWidget: OrderStatusWidget(
                backgroundColor: ColorManager.orangeLightColor,
                textColor: ColorManager.orangeDarkColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('الذهاب لصفحة الطلبات'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
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
    this.alignment = Alignment.centerRight,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final AlignmentGeometry alignment;
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
          'قيد المراجعة',
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
