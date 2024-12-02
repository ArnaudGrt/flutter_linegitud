import 'package:flutter/material.dart';

class Theme {
  static String fontFamily = "Poppins";

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2c4b17),
    onPrimary: Color(0xFFffffff),
    primaryContainer: Color(0xFF5c7e44),
    onPrimaryContainer: Color(0xFFffffff),
    secondary: Color(0xFF3b4631),
    onSecondary: Color(0xFFffffff),
    secondaryContainer: Color(0xFF6c7960),
    onSecondaryContainer: Color(0xFFffffff),
    tertiary: Color(0xFF194a4a),
    onTertiary: Color(0xFFffffff),
    tertiaryContainer: Color(0xFF4f7c7c),
    onTertiaryContainer: Color(0xFFffffff),
    error: Color(0xFF8c0009),
    onError: Color(0xFFffffff),
    errorContainer: Color(0xFFda342e),
    onErrorContainer: Color(0xFFffffff),
    surfaceDim: Color(0xFFd9dbd1),
    surface: Color(0xFFf8faf0),
    surfaceBright: Color(0xFFf8faf0),
    surfaceContainerLowest: Color(0xFFffffff),
    surfaceContainerLow: Color(0xFFf3f5ea),
    surfaceContainer: Color(0xFFedefe4),
    surfaceContainerHigh: Color(0xFFe7e9df),
    surfaceContainerHighest: Color(0xFFe1e4d9),
    onSurface: Color(0xFF191d16),
    onSurfaceVariant: Color(0xFF40443a),
    outline: Color(0xFF5c6156),
    outlineVariant: Color(0xFF787c71),
    inverseSurface: Color(0xFF2e312a),
    onInverseSurface: Color(0xFFf0f2e7),
    inversePrimary: Color(0xFFacd28f),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFb0d693),
    onPrimary: Color(0xFF071b00),
    primaryContainer: Color(0xFF779b5e),
    onPrimaryContainer: Color(0xFF000000),
    secondary: Color(0xFFc2cfb3),
    onSecondary: Color(0xFF0f1908),
    secondaryContainer: Color(0xFF88957b),
    onSecondaryContainer: Color(0xFF000000),
    tertiary: Color(0xFFa4d4d3),
    onTertiary: Color(0xFF001a1a),
    tertiaryContainer: Color(0xFF6b9998),
    onTertiaryContainer: Color(0xFF000000),
    error: Color(0xFFffbab1),
    onError: Color(0xFF370001),
    errorContainer: Color(0xFFff5449),
    onErrorContainer: Color(0xFF000000),
    surfaceDim: Color(0xFF11140e),
    surface: Color(0xFF11140e),
    surfaceBright: Color(0xFF373a33),
    surfaceContainerLowest: Color(0xFF0c0f09),
    surfaceContainerLow: Color(0xFF191d16),
    surfaceContainer: Color(0xFF1d211a),
    surfaceContainerHigh: Color(0xFF282b24),
    surfaceContainerHighest: Color(0xFF33362f),
    onSurface: Color(0xFFfafcf1),
    onSurfaceVariant: Color(0xFFc8ccbf),
    outline: Color(0xFFa0a598),
    outlineVariant: Color(0xFF808579),
    inverseSurface: Color(0xFFe1e4d9),
    onInverseSurface: Color(0xFF282b24),
    inversePrimary: Color(0xFF31501c),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );

  static ThemeData lightTheme = ThemeData(

  );

  static ThemeData darkTheme = ThemeData(

  );
}