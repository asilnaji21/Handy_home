import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/l10n/locale_keys.g.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/dotpage_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../resources/assets_manager.dart';

import '../../resources/values_manager.dart';
import '../signup_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  PageController nextPage = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1FCFB),
      body: PageView.builder(
        controller: nextPage,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        itemBuilder: (context, index) {
          return BuildPageView(
              index: index, currentPage: currentPage, nextPage: nextPage);
        },
        itemCount: 3,
      ),
    );
  }
}

class BuildPageView extends StatelessWidget {
  final int index;
  final int currentPage;
  final PageController nextPage;

  const BuildPageView(
      {required this.index, required this.currentPage, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w30),
      child: ListView(
        children: [
          SizedBoxCustom(
            height: AppHeightSize.h89,
          ),
          Image.asset(
            ImagePath.onboarding,
            width: AppWidthSize.w331,
            height: AppHeightSize.h261,
          ),
          SizedBoxCustom(
            height: AppHeightSize.h71,
          ),
          Text("${LocaleKeys.featureText.tr()} ${LocaleKeys.firstText.tr()}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          Text(LocaleKeys.subFeature1Text.tr(),
              style: Theme.of(context).textTheme.titleLarge),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          DotPageView(pageNumber: currentPage),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          CustomButton(
            text: Text(LocaleKeys.nextText.tr()),
            onPressed: () {
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SigUpScreen()),
                );
              } else {
                nextPage.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              }
            },
          ),
        ],
      ),
    );
  }
}
