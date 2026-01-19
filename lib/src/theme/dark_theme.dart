import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffff5722),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xff121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1f1f1f),
    foregroundColor: Colors.white,
  ),
  cardTheme: const CardThemeData(
    color: Color(0xff1c1c1c),
  ),
);
