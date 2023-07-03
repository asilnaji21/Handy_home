import 'package:flutter/material.dart';
import '../presentation/resources/color_manager.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      TextEditingController? controller,
      required this.text,
      this.fieldKey,
      this.minLines = 1,
      this.maxLines = 1,
      this.keyboardType,
      this.validator,
      this.obscureIconEnable = false,
      this.obscureText = false})
      : _controller = controller,
        super(key: key);
  final String text;
  final bool obscureIconEnable;
  final String? Function(String?)? validator;
  final TextEditingController? _controller;
  final bool obscureText;
  final GlobalKey<FormFieldState>? fieldKey;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: widget.fieldKey,
        validator: widget.validator,
        textAlign: TextAlign.right,
        cursorColor: Colors.black,
        obscureText: widget.obscureIconEnable ? isVisible : false,
        controller: widget._controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIcon: widget.obscureIconEnable
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade600,
                  ))
              : null,
          fillColor: ColorManager.whiteColor,

         
          filled: true,
          border: InputBorder.none,
          hintText: widget.text,
        ));
  }
}
