import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context, {
  required Color backgroundColor,
  required Color textColor,
  required String text,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: TextStyle(fontSize: 15, color: textColor),
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    duration: const Duration(seconds: 4),
    elevation: 0,
  ));
}
