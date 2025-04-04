import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';
import '../constants/font_weight.dart';

appLightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteFFFFFFColor,
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
        color: whiteFFFFFFColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: purple4C4DDCColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.black, size: 28),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: normal,
            fontFamily: GoogleFonts.inter().fontFamily)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(Colors.white)).copyWith(background: whiteFFFFFFColor),
  );
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
