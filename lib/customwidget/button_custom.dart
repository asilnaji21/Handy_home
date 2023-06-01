import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';

import '../presentation/resources/values_manager.dart';

class CustomButtonPrimary extends StatelessWidget {
  const CustomButtonPrimary({
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
        fixedSize: const Size(double.infinity, 50),
        minimumSize: Size(double.infinity, 50),
        backgroundColor: ColorManager.primaryMainEnableColor,
        textStyle: Theme.of(context).textTheme.headlineMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
