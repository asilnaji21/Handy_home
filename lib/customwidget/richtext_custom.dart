import 'package:flutter/material.dart';

class RichTextCustom extends StatelessWidget {
  const RichTextCustom(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.color,
      this.textDecoration = TextDecoration.underline})
      : super(key: key);
  final String text1;
  final String text2;
  final Color color;
  final TextDecoration textDecoration;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text1,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextSpan(
            text: text2,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: color, decoration: textDecoration),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
