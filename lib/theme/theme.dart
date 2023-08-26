import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xffFFAE42);
  static const secondary = Color(0xffA78C70);
  static const accent = Color(0xff00FFFF);
  static const neutral = Color(0xff93FF60);
  static const backgroundColor = Color(0xff1C1C27);
}

class AppTheme {
  static const _textTheme = TextTheme();
  static final themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: _textTheme,
    fontFamily: 'Lato',
  );
}
