/// Color theme constants for Betriebsanweisungen templates
/// These colors match the official German legal template requirements
library;

import 'package:flutter/material.dart';

/// Primary orange color used for all section headers and backgrounds
/// This is the legally required orange color from the official template
const Color baOrange = Color(0xFFFF6B00);

/// Off-white/cream background color for content areas
/// Provides better readability than pure white
const Color baContentBg = Color(0xFFFFFBF5);

/// Dark text color for content on light backgrounds
/// Uses Material 3 onSurface color for optimal readability
const Color baTextDark = Color(0xFF1C1B1F);

/// Light text color for text on orange backgrounds
/// Pure white for maximum contrast
const Color baTextLight = Color(0xFFFFFFFF);

/// Border color for section separators
/// Uses same dark color as text for consistency
const Color baBorder = Color(0xFF1C1B1F);

/// Returns a Material 3 ColorScheme configured for Betriebsanweisungen
///
/// The color scheme is based on the legal template requirements:
/// - Primary: Orange (#FF6B00)
/// - Surface: Off-white (#FFFBF5)
/// - Text colors: White on orange, dark on off-white
ColorScheme getBAColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: baOrange,
    primary: baOrange, // Explicitly set to exact orange (not generated variant)
    onPrimary: baTextLight,
    surface: baContentBg,
    onSurface: baTextDark,
    brightness: Brightness.light,
  );
}

/// Returns a complete ThemeData configured for Betriebsanweisungen
///
/// This theme includes:
/// - Material Design 3 components
/// - Custom color scheme matching legal requirements
/// - Optimized typography for readability
/// - Component themes for cards, buttons, etc.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: getBAThemeData(),
///   // ...
/// )
/// ```
ThemeData getBAThemeData() {
  final colorScheme = getBAColorScheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

    // Typography configuration
    textTheme: const TextTheme(
      // Product name: 36px, bold
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),

      // Section headers: 22px, bold
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),

      // Orange header titles: 16px, medium weight
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),

      // Body text: 16px, regular
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
      ),

      // Header fields: 14px, regular
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.4,
      ),

      // Pictogram labels: 14px, medium
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    ),

    // Card theme for consistent elevation and padding
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: baBorder, width: 1),
      ),
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: baOrange,
      foregroundColor: baTextLight,
      elevation: 0,
      centerTitle: true,
    ),

    // Scaffold background
    scaffoldBackgroundColor: Colors.white,

    // List tile theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
