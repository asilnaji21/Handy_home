import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/category_screen.dart';

import '../../resources/assets_manager.dart';
import 'HomeComponents/customer_comment_widget.dart';
import 'HomeComponents/stare_rating_widget.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 30,
          top: 18,
          right: 30,
        ),
        children: [
          const CustomHeaderWidget(
            title: 'تركيب حنفية مياه',
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(
                        ImagePath.serviceImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      clipBehavior: Clip.antiAlias,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 25,
                  left: 25,
                ),
                child: StareRatingWidget(ratingNumber: '4.6'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تركيب حنفية مياه',
                style: StyleManger.headline1(fontSize: 18),
              ),
              Text('30 - 50 شيكل'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'تتضمن هذه الخدمة التالي:',
            style: StyleManger.headline1(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          ...include.map((e) => Text('✅ $e')).toList(),
          const SizedBox(
            height: 16,
          ),
          Text(
            'لا تتضمن هذه الخدمة التالي:',
            style: StyleManger.headline1(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          ...exclude.map((e) => Text('❌ $e')).toList(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تعليقات العملاء',
                style: StyleManger.headline1(fontSize: 16),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.buttonBackgroundColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'قيم تجربتك',
                    style: TextStyle(
                      color: ColorManager.primaryMainEnableColor,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomerCommentWidget(),
          const CustomerCommentWidget(),
          const CustomerCommentWidget(),
          const CustomerCommentWidget(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('اطلب هذه الخدمة'),
        ),
      ),
    );
  }
}

List<String> include = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];

List<String> exclude = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];
