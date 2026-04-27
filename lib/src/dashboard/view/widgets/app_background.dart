import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 390; 

    return Stack(
      children: [
        Container(color: const Color(0xFFB5E2F4)),

        /// 🌫️ BLUR CIRCLES (FIGMA MATCH)
        _buildBlurredCircle(150, 600, 383, Colors.white.withOpacity(0.30), scale, 40),
        _buildBlurredCircle(-153, 575, 383, Colors.white.withOpacity(0.60), scale, 50),
        _buildBlurredCircle(154, 108, 383, Colors.white.withOpacity(0.50), scale, 40),
        _buildBlurredCircle(-146, -201, 383, Colors.white, scale, 60),
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