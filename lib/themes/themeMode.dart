import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade400,
    foregroundColor: Colors.grey.shade900,
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    onSurface: Colors.black, // Text color on surface
    primary: Colors.grey.shade900,
    onPrimary: Colors.white, // Text color on primary
    secondary: Colors.grey.shade600,
    onSecondary: Colors.white, // Text color on secondary
    error: Colors.red,
    onError: Colors.yellow,
    // Additional properties to avoid purple defaults
    primaryContainer: Colors.grey.shade800,
    onPrimaryContainer: Colors.white,
    secondaryContainer: Colors.grey.shade500,
    onSecondaryContainer: Colors.white,
    tertiary: Colors.grey.shade700,
    onTertiary: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
  ),
);

ThemeData darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    onSurface: Colors.white, // Text color on surface
    primary: Colors.white,
    onPrimary: Colors.white, // Text color on primary
    secondary: Colors.grey.shade200,
    onSecondary: Colors.black, // Text color on secondary
    error: Colors.redAccent,
    onError: Colors.black,
    // Additional properties to avoid purple defaults
    primaryContainer: Colors.grey.shade300,
    onPrimaryContainer: Colors.black,
    secondaryContainer: Colors.grey.shade700,
    onSecondaryContainer: Colors.black,
    tertiary: Colors.grey.shade300,
    onTertiary: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
  ),
);
