import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
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
              print(index);
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
                  Text('6 خدمات فرعية')
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الأكثر طلباً'),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: ColorManager.brownColor,
                ),
                label: Text(
                  'عرض المزيد',
                  style: StyleManger.headline1(color: ColorManager.brownColor,fontSize: 14),
                )),
          ],
        )
      ],
    );
  }
}
