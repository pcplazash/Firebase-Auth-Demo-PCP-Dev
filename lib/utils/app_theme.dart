import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color(0xffEBF3FF);
  static Color lightPrimaryColor = const Color(0xff004881);
  static Color lightSecondaryColor = const Color(0xff009E20);
  static Color lightTertiaryColor = const Color(0xff55C5F8);
  static Color lightPrimaryContainerColor = const Color(0xffA5E2FE);
  static Color lightSecondaryContainerColor = const Color(0xffBB9FEF).withOpacity(0.5);


  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: lightPrimaryColor,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      tertiary: lightTertiaryColor,
      primaryContainer: lightPrimaryContainerColor,
      secondaryContainer: lightSecondaryContainerColor,

      background: lightBackgroundColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
