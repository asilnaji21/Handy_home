import 'package:flutter/material.dart';
import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required TextEditingController fullNameController,
    required this.text,
    this.suffixIcon,
  })  : _fullNameController = fullNameController,
        super(key: key);
  final String text;
  final Widget? suffixIcon;
  final TextEditingController _fullNameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: ColorManager.primaryMainEnableColor,
      borderRadius: BorderRadius.all(Radius.circular(AppRadiusSize.r2)),
      child: TextFormField(
          textAlign: TextAlign.right,
          controller: _fullNameController,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: ColorManager.whiteColor,
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                horizontal: AppWidthSize.w16, vertical: AppHeightSize.h16),
            hintText: text,
            hintStyle: const TextStyle(
              color: ColorManager.placeholderColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.primaryMainEnableColor,
                width: AppWidthSize.w1,
              ),
              borderRadius: BorderRadius.circular(AppRadiusSize.r66),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.whiteColor,
                width: AppWidthSize.w1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          )),
    );
  }
}
