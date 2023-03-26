import 'package:flutter/material.dart';
import 'package:handy_home_app/customwidget/sizedbox_custom.dart';
import 'package:handy_home_app/presentation/resources/values_manager.dart';

class HeaderCustom extends StatelessWidget {
  const HeaderCustom(
      {Key? key,
      required this.text1,
      this.subText = "",
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textAlign=TextAlign.start })
      : super(key: key);
  final String text1;
  final String subText;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBoxCustom(
          height: AppHeightSize.h8,
        ),
        Text(
          subText,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: textAlign,
        ),
      ],
    );
  }
}
