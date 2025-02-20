import 'package:flutter/material.dart';

/// A custom text theme.
class ExpyrTextTheme extends TextTheme {
  @override
  TextStyle? get titleLarge =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  TextStyle? get titleMedium =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  @override
  TextStyle? get labelMedium => const TextStyle(fontSize: 14);
}
