import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontsize, FontWeight fontweight, Color color) {
  return TextStyle(
    fontSize: fontsize,
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontweight,
  );
}

// Headings\H1 Style
TextStyle getHeading1Style(
    {double fontsize = AppFontSize.s26, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.extrabold, color);
}

// Headings/H2 style
TextStyle getHeading2Style(
    {double fontsize = AppFontSize.s22, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.extrabold, color);
}

// Headings/H3style
TextStyle getHeading3Style(
    {double fontsize = AppFontSize.s18, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.extrabold, color);
}

// Body/Description
TextStyle getDescriptionStyle(
    {double fontsize = AppFontSize.s14, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.light, color);
}

// Body/DescriptionBold

TextStyle getDescBoldStyle(
    {double fontsize = AppFontSize.s14, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.extrabold, color);
}

// subTitle style
TextStyle getSubTitleStyle(
    {double fontsize = AppFontSize.s16, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.light, color);
}

// Chips/Bold style
TextStyle getChipsBoldleStyle(
    {double fontsize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.extrabold, color);
}
