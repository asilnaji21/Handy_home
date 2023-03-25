import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';

import '../presentation/resources/values_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final Text text;

  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: text,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(AppWidthSize.w333, AppSize.s60),
        primary: ColorManager.primaryMainEnableColor,
        textStyle: Theme.of(context).textTheme.headlineMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(46),
        ),
      ),
    );
  }
}
