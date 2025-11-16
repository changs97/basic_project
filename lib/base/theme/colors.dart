import 'package:flutter/material.dart';

class BaseColors {
  BaseColors._();

  // Brand palette
  static const Color primary = Color(0xFF6750A4);
  static const Color secondary = Color(0xFF625B71);
  static const Color tertiary = Color(0xFF7D5260);

  // Semantic
  static const Color success = Color(0xFF1ABC9C);
  static const Color warning = Color(0xFFF39C12);
  static const Color danger = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Neutral
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color gray100 = Color(0xFFF7F7F8);
  static const Color gray200 = Color(0xFFEDEDEF);
  static const Color gray300 = Color(0xFFDADADD);
  static const Color gray400 = Color(0xFFB9BAC0);
  static const Color gray500 = Color(0xFF8F9098);
  static const Color gray600 = Color(0xFF6B6C72);
  static const Color gray700 = Color(0xFF4B4C52);
  static const Color gray800 = Color(0xFF2E2F33);
  static const Color gray900 = Color(0xFF16171A);

  static ColorScheme colorScheme({Brightness brightness = Brightness.light}) {
    final isLight = brightness == Brightness.light;
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: white,
      secondary: secondary,
      onSecondary: white,
      error: danger,
      onError: white,
      background: isLight ? gray100 : gray900,
      onBackground: isLight ? gray900 : gray100,
      surface: isLight ? white : gray800,
      onSurface: isLight ? gray900 : gray100,
    );
  }
}


