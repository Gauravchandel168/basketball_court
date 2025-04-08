// import 'package:flutter/material.dart';
//
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../colors/app_colors.dart';
// import '../constants/font_weight.dart';
//
// appLightTheme(BuildContext context) {
//   return ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: whiteFFFFFFColor,
//
//     textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
//     appBarTheme: Theme.of(context).appBarTheme.copyWith(
//         color: whiteFFFFFFColor,
//         systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: purple4C4DDCColor,
//             statusBarIconBrightness: Brightness.light),
//         iconTheme: const IconThemeData(color: Colors.black, size: 28),
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: normal,
//             fontFamily: GoogleFonts.inter().fontFamily)),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(Colors.white)).copyWith(background: whiteFFFFFFColor),
//   );
// }
//
// MaterialColor createMaterialColor(Color color) {
//   List strengths = <double>[.05];
//   Map<int, Color> swatch = {};
//   final int r = color.red, g = color.green, b = color.blue;
//
//   for (int i = 1; i < 10; i++) {
//     strengths.add(0.1 * i);
//   }
//   for (var strength in strengths) {
//     final double ds = 0.5 - strength;
//     swatch[(strength * 1000).round()] = Color.fromRGBO(
//       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//       1,
//     );
//   }
//   return MaterialColor(color.value, swatch);
// }
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';
import '../constants/font_weight.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  primaryColor: const Color(0xFF003E47),
  secondaryHeaderColor: const Color(0xFFCFEC7E),
  primaryColorDark: Colors.black,
  shadowColor: Colors.grey[300],
 // scaffoldBackgroundColor: Colors.transparent,
  textTheme: TextTheme(
    titleLarge:
    TextStyle(color: darkBlue242B42CColor, fontFamily: GoogleFonts.plusJakartaSans().fontFamily),
    titleSmall:
    TextStyle(color: darkBlue242B42CColor, fontFamily: GoogleFonts.plusJakartaSans().fontFamily),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    //    selectedItemColor: ColorResources.themeLightBackgroundColor
  ),
  appBarTheme: const AppBarTheme(
      shadowColor: whiteFFFFFFColor,
      surfaceTintColor: whiteFFFFFFColor,
      foregroundColor: whiteFFFFFFColor,
      color: whiteFFFFFFColor,
      // backgroundColor: whiteFFFFFFColor,
      scrolledUnderElevation: 0,

      actionsIconTheme: IconThemeData(
          color: whiteFFFFFFColor

      )
  ),

);



/// light theme configuration.
appLightTheme(BuildContext context) {
  return
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: createMaterialColor(whiteFFFFFFColor),
      // backgroundColor: whiteFFFFFFColor,
      scaffoldBackgroundColor: whiteFFFFFFColor,
      textTheme: ThemeData.light().textTheme,

      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          color: whiteFFFFFFColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: whiteFFFFFFColor,
              statusBarIconBrightness: Brightness.light),
          iconTheme: const IconThemeData(color: blue242B42Color, size: 28),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: blue242B42Color,
              fontSize: 19,
              fontWeight: normal,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily)
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  //sfProDisplayFonts
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}


