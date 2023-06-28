import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

import 'HomeComponents/home_category_lable_widget.dart';
import 'HomeComponents/home_horizontal_category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
          ),
          children: [
            Text(
              'الرئيسية',
              style: StyleManger.headline1(),
            ),
            GridView.builder(
              padding: const EdgeInsets.only(top: 21),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  NavigationManager.pushNamed(RouteConstants.categoryRoute);
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.cleaningImage),
                      Text(
                        'النجارة',
                        style: StyleManger.headline1(fontSize: 14),
                      ),
                      const Text('6 خدمات فرعية')
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.customServiceImage),
                    Text(
                      'لم تعثر على الخدمة المطلوبة؟',
                      style: StyleManger.headline1(fontSize: 14),
                    ),
                    const Text(
                      'يمكنك طلب خدمة مخصصة بما يتوافق مع احتياجاتك باضافة كافة التفاصيل حول الخدمة المطلوبة.',
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NavigationManager.pushNamed(
                            RouteConstants.orderCustomServiceRoute);
                      },
                      child: const Text('طلب خدمة مخصصة'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        HomeCategoryLabelWidget(
          title: 'الأكثر طلباً',
          onPressed: () {},
        ),
        const HomeHorizontalCategoryWidget(),
        const SizedBox(
          height: 10,
        ),
        HomeCategoryLabelWidget(
          title: 'المضافة حديثاً',
          onPressed: () {},
        ),
        const HomeHorizontalCategoryWidget(),
      ],
    );
  }
}
