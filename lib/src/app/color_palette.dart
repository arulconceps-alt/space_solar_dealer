import 'package:flutter/material.dart';

class ColorPalette {
  static const Color background = Color(0xFF26A7DF); // splash Screen Fill
  static const Color surface = Color(0xFF313038); // Rectangle 39515 Fill
  static const Color button1 = Color(0xFF4E4E4E); // onboardscreen button1
  static const Color button2 = Color(0xFFFFFFFF); // onboardscreen button2
  static const Color snackbar = Color(0xFF37B158);
  static const Color whitetext = Color(0xFFFFFFFF);
  static const Color bottomtext = Color(0xFF282828);
  static const Color textfiledin = Color(0xFF484848);
  static const Color bordertextbox = Color(0xFFE2E2E2);
  static const Color active = Color(0xFF00C951);
  static const Color alert = Color(0xFFFF6900);
  static const Color pending = Color(0xFFEA1F27);


  // Brand - Gold accent (buttons, active dot)
  static const Color primary = Color(0xFFDFC55C); // Vector Fill gold

  // Status - from Figma
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFE71E25); // Vector Fill red
  static const Color warning = Color(0xFFF59E0B);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, Color(0xFFE8D88A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient scaffoldGradient = LinearGradient(
    colors: [Color(0xFFB5E2F4), Color(0xFFD8F0FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFE8D88A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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