import 'package:flutter/material.dart';

class SizedBoxCustom extends StatelessWidget {
 final   double? height;
 final   double? width;
 const SizedBoxCustom( {Key? key,  this.height,  this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
