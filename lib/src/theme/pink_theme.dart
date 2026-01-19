import 'package:flutter/material.dart';

final ThemeData pinkTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffe91e63),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xfffafafa),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffe91e63),
    foregroundColor: Colors.white,
  ),
);
