import 'package:flutter/material.dart';

/// A utility class defining application-wide colors.
class AppColor {
  static const Color cream = Color(0xffF9FDF8);
  static const lightRedColor = Color(0xffFFE2E0);
  static const Color green = Color(0xff0A5F3C);
  static const Color white = Colors.white;
  static MaterialColor appMaterialColor = createMaterialColor(green);
}

/// Returns [MaterialColor] for passed [Color]
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
