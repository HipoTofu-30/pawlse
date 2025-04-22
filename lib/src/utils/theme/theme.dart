import 'package:flutter/material.dart';
import 'package:pawlse/src/utils/widget_theme/text_theme/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme =
      ThemeData(brightness: Brightness.light, textTheme: TTheme.lightTextTheme);
  static ThemeData darkTheme =
      ThemeData(brightness: Brightness.dark, textTheme: TTheme.darkTextTheme);
}
