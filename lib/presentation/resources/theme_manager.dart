import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/font_manager.dart';

import 'color_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      fontFamily: 'AvenirArabic',
      scaffoldBackgroundColor: ColorManager.background,
      // useMaterial3: true,
      // ---------main colors ------------
      primaryColor: ColorManager.whiteColor,
      primaryColorDark: ColorManager.darkTextPrimaryColor,
      primaryColorLight: ColorManager.whiteColor,
      disabledColor: ColorManager.primaryMainDisableColor,
      colorScheme: ColorScheme.light(
        error: ColorManager.statusErrorColor,
      ),
      // splashColor: ColorManager.lightPrimary,
      //** appar theme  **
      appBarTheme: AppBarTheme(
        centerTitle: false,
        color: ColorManager.whiteColor,
        elevation: AppSize.s4,
        titleTextStyle: getHeading1Style(
          fontsize: 16,
          color: ColorManager.darkTextPrimaryColor,
        ),
      ),

      //button theme

      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.primaryMainDisableColor,
        buttonColor: ColorManager.primaryMainEnableColor,
      ),
      //elevted button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getHeading1Style(
              color: ColorManager.darkTextPrimaryColor,
              fontsize: AppFontSize.s12),
          backgroundColor: ColorManager.primaryMainEnableColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      //text theme
      textTheme: TextTheme(
        displayLarge: getHeading1Style(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s22),
        headlineLarge: getChipsBoldleStyle(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s14),
        headlineMedium: getDescBoldStyle(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s14),

        titleLarge: getDescriptionStyle(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s14),

        bodyLarge: getHeading2Style(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s16), //caption
        bodySmall: getHeading2Style(
            color: ColorManager.darkTextPrimaryColor,
            fontsize: AppFontSize.s14), //bodyText1
      ),

      // input decoration theme  (Text form field )
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        //content padding
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w16, vertical: AppHeightSize.h16),
        //hint Style
        hintStyle: StyleManger.headline2(color: Colors.grey),
        //label Style Lama Al user Ekteb Bel TextFormField
        // labelStyle: StyleManger.headline1(),
        errorStyle: TextStyle(height: 0.8, fontWeight: FontWeight.normal),
        //enabeld border style
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // fe halet Al focus
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.greyColor, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        //error border style
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.statusErrorColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focus error border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.greyColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}

// //2018
// // headline1    96.0  light   -1.5
// // headline2    60.0  light   -0.5
// // headline3    48.0  regular  0.0
// // headline4    34.0  regular  0.25
// // headline5    24.0  regular  0.0
// // headline6    20.0  medium   0.15
// // subtitle1    16.0  regular  0.15
// // subtitle2    14.0  medium   0.1
// // body1        16.0  regular  0.5   (bodyText1)
// // body2        14.0  regular  0.25  (bodyText2)
// // button       14.0  medium   1.25
// // caption      12.0  regular  0.4
// // overline     10.0  regular  1.5
