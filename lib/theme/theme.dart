import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xffFFAE42);
  static const secondary = Color(0xffA78C70);
  static const accent = Color(0xff00FFFF);
  static const neutral = Color(0xff93FF60);
  static const backgroundColor = Color(0xff1C1C27);
}

TextTheme? _getTextTheme() => const TextTheme().apply(
      bodyColor: Colors.white,
      decorationColor: Colors.white,
    );

class AppTheme {
  static final themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: _getTextTheme(),
    fontFamily: 'Lato',
  );
}
