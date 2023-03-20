// import 'package:flutter/material.dart';


// import 'color_manager.dart';
// import 'style_manager.dart';
// import 'values_manager.dart';

// ThemeData getApplicationTheme() {
//   return ThemeData(
//       // ---------main colors ------------ 
//       primaryColor: ColorManager.whiteColor,
//       primaryColorDark: ColorManager.darkTextPrimaryColor,
//       primaryColorLight: ColorManager.whiteColor,
//       disabledColor: ColorManager.primaryMainDisableColor,
//    errorColor: ColorManager.statusErrorColor,
//       // splashColor: ColorManager.lightPrimary,

//       //** appar theme  **
//       appBarTheme: AppBarTheme(
//           centerTitle: false,
//           color: ColorManager.whiteColor,
//           elevation: Appsize.s4,
        
//           titleTextStyle:
//               getRegularStyle(fontsize: 16, color: ColorManager.darkTextPrimaryColor)),

//       //button theme

//       buttonTheme: ButtonThemeData(
//         shape: const StadiumBorder(),
//         disabledColor: ColorManager.primaryMainDisableColor,
//         buttonColor: ColorManager.primaryMainEnableColor,
//       ),
//       //elevted button
//       elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               textStyle: getRegularStyle(
//                   color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s17),
//               primary: ColorManager.primaryMainEnableColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ))),
//       //text theme
//       textTheme: TextTheme(
//         displayLarge: getSemiBoldStyle(
//             color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s16), //2021
//         headlineLarge: getSemiBoldStyle(
//             color: ColorManager.darkTextPrimaryColor,
//             fontsize:
//                 FontSize.s16), //2018 متعمليييش مكس ما بين مجموعتين التيمممم

//         headlineMedium: getRegularStyle(
//             color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s14),

//         titleLarge: getRegularStyle(
//             color: ColorManager.darkTextPrimaryColor,
//             fontsize: FontSize.s14), 

//         titleMedium: getRegularStyle(
//             color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s16),
//         bodyLarge: getMediumStyle(
//             color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s16), //caption
//         bodySmall: getMediumStyle(
//             color: ColorManager.darkTextPrimaryColor, fontsize: FontSize.s14), //bodyText1
//       ),

     
//       // input decoration theme  (Text form field )
//       inputDecorationTheme: InputDecorationTheme(
//         //content padding
//         contentPadding: const EdgeInsets.all(AppPadding.p8),
//         //hint Style
//         hintStyle:
//             getRegularStyle(color: ColorManager.greyColor, fontsize: FontSize.s14),
//         //label Style Lama Al user Ekteb Bel TextFormField
//         labelStyle:
//             getMediumStyle(color: ColorManager.greyColor, fontsize: FontSize.s14),
//         errorStyle: getRegularStyle(color: ColorManager.statusErrorColor),
//         //enabeld border style
//         enabledBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.primaryMainEnableColor, width: Appsize.s1_5),
//             borderRadius: BorderRadius.all(Radius.circular(Appsize.s8))),

//         // fe halet Al focus
//         focusedBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.greyColor, width: Appsize.s1_5),
//             borderRadius: BorderRadius.all(Radius.circular(Appsize.s8))),
//         //error border style
//         errorBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.statusErrorColor, width: Appsize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(Appsize.s8))),
//         //focus error border style
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: ColorManager.statusErrorColor, width: Appsize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(Appsize.s8))),
//       ));
// }


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