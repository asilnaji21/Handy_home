import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/presentation/view/onBoarding/onboarding.dart';

import '../../../customwidget/sizedbox_custom.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -100 * (1 - _animation.value)),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    width: 120.41 * _animation.value,
                    height: 135.92 * _animation.value,
                    child: SvgPicture.asset(ImagePath.iconHome),
                  ),
                ),
                SizedBoxCustom(height: AppHeightSize.h8),
                SvgPicture.asset(ImagePath.wordHome,
                    width: AppWidthSize.w122, height: AppHeightSize.h35_45),
                SizedBoxCustom(height: AppHeightSize.h8),
                SvgPicture.asset(ImagePath.takeCare)
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, 900 * (1 - _animation.value)),
            child: Image.asset(
              ImagePath.splashBackground,
              width: 900,
              height: 900,
            ),
          ),
        ],
      ),
    );
  }
}
