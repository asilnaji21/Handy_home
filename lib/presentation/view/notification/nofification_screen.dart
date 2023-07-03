import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/service_info_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 5),
            child: Text(
              'الاشعارات',
              style: StyleManger.headline1(),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  // its just simulation for the ui idea
                  if (index == 0) {
                    return Text(
                      'الحديثة',
                      style: StyleManger.headline1(fontSize: 18),
                    );
                  } else if (index == 5) {
                    return Text(
                      'القديمة',
                      style: StyleManger.headline1(fontSize: 18),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      print(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(3, 0),
                              color: ColorManager.greenDarkColor,
                            )
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'تنفيذ الخدمة بنجاح٬ اضغط هنا للتقييم',
                                  style: StyleManger.headline1(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'منذ دقيقة',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('حالة الطلب:'),
                              OrderStatusWidget(
                                text: 'مكتمل',
                                backgroundColor: ColorManager.greenLightColor,
                                textColor: ColorManager.greenDarkColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
