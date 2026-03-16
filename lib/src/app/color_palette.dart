import 'package:flutter/material.dart';

class ColorPalette {
  // Backgrounds - Figma dark theme
  static const Color background = Color(0xFF1C1B20); // splash Screen Fill
  static const Color surface = Color(0xFF313038); // Rectangle 39515 Fill
  static const Color surfaceVariant = Color(0xFF413E3D); // BG Color Fill
  static const Color surfaceDark = Color(0xFF333236); // Ellipse 6065 Fill
  static const Color surfaceLight = Color(0xFF333236);
  static const Color backgroundDark = Color(0xFF24232A);


  static const Color snackbar = Color(0xFF37B158);

  // Brand - Gold accent (buttons, active dot)
  static const Color primary = Color(0xFFDFC55C); // Vector Fill gold
  static const Color accent = Color(0xFFDFC55C);
  static const Color accentGold = Color(0xFFDFC55C);
  static const Color secondary = Color(0xFF00ABE4); // Vector Fill blue

  // Glows
  static Color primaryGlow = primary.withValues(alpha: 0.15);
  static Color secondaryGlow = secondary.withValues(alpha: 0.15);
  static Color accentGlow = accent.withValues(alpha: 0.15);

  // Typography - on dark
  static const Color textPrimary = Color(0xFFFFFFFF); // Battery Fill
  static const Color textSecondary = Color(
    0xCCFFFFFF,
  ); // Description 0.8 opacity
  static const Color textTertiary = Color(0x99FFFFFF); // Home Indicator 0.6

  // Borders / outline
  static const Color outline = Color(0xFF6D6B94); // Rectangle 39513 Stroke
  static const Color borderSubtle = Color(0x1AFFFFFF); // BG Color Stroke 0.1

  // Status - from Figma
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFE71E25); // Vector Fill red
  static const Color warning = Color(0xFFF59E0B);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, Color(0xFFE8D88A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFE8D88A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [background, surfaceVariant],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Widget buildLuxGlow(
    Alignment alignment,
    Color color, {
    double size = 400,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }

  static Color white(double alpha) => Colors.white.withValues(alpha: alpha);
  static Color black(double alpha) => Colors.black.withValues(alpha: alpha);
}
