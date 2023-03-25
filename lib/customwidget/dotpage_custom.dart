import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';

class DotPageView extends StatelessWidget {
  final int pageNumber;

  DotPageView({required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == pageNumber ? 25 : 9,
            height: 6,
            decoration: BoxDecoration(
              color: i == pageNumber
                  ? ColorManager.primaryMainEnableColor
                  : ColorManager.secondaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
      ],
    );
  }
}
