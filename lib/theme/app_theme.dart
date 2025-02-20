import 'package:flutter/material.dart';

import '../common/constants.dart';
import 'app_color.dart';
import 'expyr_text_theme.dart';

/// Defines global theme.
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primarySwatch: AppColor.appMaterialColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.green,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: ExpyrTextTheme(),
      scaffoldBackgroundColor: AppColor.cream,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.cream,
        elevation: 0,
        scrolledUnderElevation: 0.0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColor.green,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radiusMedium),
            ),
          ),
          backgroundColor: AppColor.green,
        ),
      ),
      cardTheme: const CardTheme(color: AppColor.white));
}
