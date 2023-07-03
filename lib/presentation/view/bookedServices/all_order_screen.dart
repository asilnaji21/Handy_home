import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../home/service_info_screen.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 90,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      ImagePath.serviceImage,
                      fit: BoxFit.fill,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تركيب حنفية مياه',
                          ),
                          Text('التاريخ: 10 مايو 2023'),
                          Text('الوقت: 12:45 مساء'),
                        ],
                      ),
                    )),
                const Expanded(
                    child: OrderStatusWidget(
                  text: 'مرفوض',
                  alignment: Alignment.bottomCenter,
                  backgroundColor: ColorManager.redLightColor,
                  textColor: ColorManager.redDarkColor,
                ))
              ],
            ),
          ),
        ),
        itemCount: 20,
      ),
    );
  }
}
