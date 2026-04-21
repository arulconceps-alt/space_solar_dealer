import 'package:flutter/material.dart';
import 'dart:ui';

class RegisterBlurCircle extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final Color color;
  final double scale;
  final double blur;
  const RegisterBlurCircle({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    required this.color,
    required this.scale,
    this.blur = 50.0, // Default blur value
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left * scale,
      top: top * scale,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
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



