import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 390; // base width from Figma

    return Stack(
      children: [
        /// 🎨 BASE COLOR
        Container(color: const Color(0xFFB5E2F4)),

        /// 🌫️ BLUR CIRCLES (FIGMA MATCH)
        _buildBlurredCircle(163, 956, 383, Colors.white.withOpacity(0.40), scale, 40),
        _buildBlurredCircle(-153, 575, 383, Colors.white.withOpacity(0.60), scale, 50),
        _buildBlurredCircle(154, 108, 383, Colors.white.withOpacity(0.50), scale, 40),
        _buildBlurredCircle(-146, -201, 383, Colors.white, scale, 60),
        /// 📱 CONTENT
        child,
      ],
    );
  }

  Widget _buildBlurredCircle(
      double left,
      double top,
      double size,
      Color color,
      double scale,
      double blurAmount,
      ) {
    return Positioned(
      left: left * scale,
      top: top * scale,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          width: size * scale,
          height: size * scale,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}