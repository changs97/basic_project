import 'package:basic_project/base/theme/colors.dart';
import 'package:basic_project/base/theme/text_styles.dart';
import 'package:flutter/material.dart';

class BaseTheme {
  BaseTheme._();

  static ThemeData light() {
    final scheme = BaseColors.colorScheme(brightness: Brightness.light);
    final text = BaseTextStyles.textTheme(scheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: scheme.background,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: text.labelLarge,
          side: BorderSide(color: scheme.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.primary),
        ),
      ),
    );
  }
}


