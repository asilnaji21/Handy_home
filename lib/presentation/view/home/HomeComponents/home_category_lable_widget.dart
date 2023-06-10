import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';

class HomeCategoryLabelWidget extends StatelessWidget {
  const HomeCategoryLabelWidget({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: StyleManger.headline1(fontSize: 16),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shadowColor: Colors.white,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: ColorManager.brownColor,
                ),
                label: Text(
                  'عرض المزيد',
                  style: StyleManger.headline1(
                      color: ColorManager.brownColor, fontSize: 14),
                )),
          ),
        ],
      ),
    );
  }
}
