import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/customwidget/sizedbox_custom.dart';

import '../presentation/resources/assets_manager.dart';
import '../presentation/resources/values_manager.dart';

class HeaderCustom extends StatelessWidget {
  const HeaderCustom({Key? key, required this.text1, required this.subText, this.crossAxisAlignment =CrossAxisAlignment.center})
      : super(key: key);
  final String text1;
  final String subText;
 final CrossAxisAlignment crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(subText, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
