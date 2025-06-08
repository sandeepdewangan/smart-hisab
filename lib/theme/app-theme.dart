import 'package:flutter/material.dart';
import 'package:smart_hisab/theme/pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.primaryColor,
      elevation: 0,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}
