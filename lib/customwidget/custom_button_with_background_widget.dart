import 'package:flutter/material.dart';

class CustomButtonWithBackgroundWidget extends StatelessWidget {
  const CustomButtonWithBackgroundWidget({
    this.onPressed,
    required this.text,
    this.boxShadow,
    Key? key,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: boxShadow
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
