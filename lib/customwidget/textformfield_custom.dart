import 'package:flutter/material.dart';
import '../presentation/resources/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required TextEditingController controller,
      required this.text,
      this.validator,
      this.suffixIcon,
      this.obscureText = false})
      : _controller = controller,
        super(key: key);
  final String text;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController _controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        textAlign: TextAlign.right,
        cursorColor: Colors.black,
        obscureText: obscureText,
        controller: _controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          fillColor: ColorManager.whiteColor,
          filled: true,
          border: InputBorder.none,
          hintText: text,
        ));
  }
}
