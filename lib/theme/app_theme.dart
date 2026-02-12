import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF0B1120);
  static const Color card = Color(0xFF111827);
  static const Color neon = Color(0xFF00E5A8);
  static const Color neonSoft = Color(0xFF00C896);
  static const Color greyText = Colors.white70;

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: background,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    useMaterial3: true,
  );
}
