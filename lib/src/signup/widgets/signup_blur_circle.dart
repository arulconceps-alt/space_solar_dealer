import 'dart:ui';
import 'package:flutter/material.dart';

class SignupBlurCircle extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final double opacity;

  const SignupBlurCircle({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}