import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const primaryColor = Color(0xFF166534);
  const secondaryColor = Color(0xFFFACC15);
  const surfaceColor = Color(0xFFF4F7F5);

  final colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: secondaryColor,
    surface: surfaceColor,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: surfaceColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 15),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

