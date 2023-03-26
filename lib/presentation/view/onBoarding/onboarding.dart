import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/view/authentication/signup_view.dart';

import '../../../app/l10n/locale_keys.g.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/dotpage_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import '../../resources/assets_manager.dart';

import '../../resources/values_manager.dart';

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
      backgroundColor: ColorManager.onBoardingColor,
      body: PageView.builder(
        controller: nextPage,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return BuildPageView(
              index: index,
              currentPage: currentPage,
              nextPage: nextPage,
              featureText: LocaleKeys.firstFeatureText.tr(),
              subFeatureText: LocaleKeys.subFeature1Text.tr(),
            );
          } else if (index == 1) {
            return BuildPageView(
              index: index,
              currentPage: currentPage,
              nextPage: nextPage,
              featureText: LocaleKeys.secondFeatureText.tr(),
              subFeatureText: LocaleKeys.subFeature2Text.tr(),
            );
          } else {
            return BuildPageView(
              index: index,
              currentPage: currentPage,
              nextPage: nextPage,
              featureText: LocaleKeys.thirdFeatureText.tr(),
              subFeatureText: LocaleKeys.subFeature2Text.tr(),
            );
          }
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
  final String featureText;
  final String subFeatureText;

  const BuildPageView({
    required this.index,
    required this.currentPage,
    required this.nextPage,
    required this.featureText,
    required this.subFeatureText,
  });

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
          Text(featureText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          Text(subFeatureText, style: Theme.of(context).textTheme.titleLarge),
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
                NavigationManager.navigationConfiguration
                    .pushNamed(RouteConstants.signupRoute);
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
