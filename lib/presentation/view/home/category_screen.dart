import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

import '../../resources/assets_manager.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                      onPressed: () {
                        NavigationManager.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ColorManager.brownColor,
                      )),
                ),
                const Spacer(),
                Text(
                  'خدمات السباكة',
                  style: StyleManger.headline1(),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              style: StyleManger.headline2(fontSize: 16),
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'ابحث باسم الخدمة المطلوبة',
                  hintStyle: StyleManger.headline2(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 30,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) => SizedBox(
                  height: 280,
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.asset(
                            ImagePath.serviceImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                          clipBehavior: Clip.antiAlias,
                        ),
                        Text(
                          'تنضيف داخلي: كنب وسجاد',
                          textAlign: TextAlign.right,
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        Text(
                          '30 - 50 ش',
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
