import 'package:flutter/material.dart';

class C {
  static const navy = Color(0xFF123E5A);
  static const secondary = Color(0xFF2F6F91);
  static const amber = Color(0xFFE6A23C);
  static const green = Color(0xFF2F8A68);
  static const text = Color(0xFF183142);
  static const muted = Color(0xFF718391);
  static const line = Color(0xFFDCE5EA);
  static const bg = Color(0xFFF5F8FA);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: C.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.navy,
      primary: C.navy,
      secondary: C.amber,
      surface: Colors.white,
    ),
    fontFamily: 'sans',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: C.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: C.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: C.navy, width: 1.4),
      ),
    ),
  );
}
