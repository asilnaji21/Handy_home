import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';

class OrderedTabButtonWidget extends StatelessWidget {
  const OrderedTabButtonWidget({
    this.onPressed,
    required this.text,
    required this.index,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  final void Function()? onPressed;
  final int index;
  final String text;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: index == selectedIndex
                ? Colors.white
                : ColorManager.placeholderColor,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                index == selectedIndex ? ColorManager.brownColor : Colors.white,
            fixedSize: const Size(double.infinity, 54)),
      ),
    );
  }
}
