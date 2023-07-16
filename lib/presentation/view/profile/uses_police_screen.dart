import 'package:flutter/material.dart';

import 'package:handy_home_app/data/models/become_service_provider_info_mdoel.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

import '../home/category_screen.dart';

class UsersPolicesScreen extends StatefulWidget {
  const UsersPolicesScreen({Key? key}) : super(key: key);

  @override
  State<UsersPolicesScreen> createState() => _UsersPolicesScreenState();
}

class _UsersPolicesScreenState extends State<UsersPolicesScreen> {
  bool isScroll = false;
  ScrollController scrollController = ScrollController();
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, right: 30),
            child: CustomHeaderWidget(
              title: 'سياسية الاستخدام',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              children: [
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '''
باستخدام تطبيقنا ، فإنك تقر بأنك قد قرأت وفهمت ووافقت على االلتزام بسياسة االستخدام هذه وأي شروط 
وأحكام أو إرشادات إضافية مقدمة في التطبيق.
سياسة االستخدام لتطبيق home handy !تحدد هذه الوثيقة الشروط واألحكام التي تحكم استخدامك لتطبيقنا 
والخدمات المقدمة من خالله. من خالل الوصول إلى تطبيقنا أو استخدامه ، فإنك توافق على االمتثال وااللتزام 
بسياسة االستخدام التالية
''',
                        ),
                        ...usesPolices
                            .map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '• ${e.title}',
                                    style: StyleManger.headline1(fontSize: 14),
                                  ),
                                  Text(
                                    e.details,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
