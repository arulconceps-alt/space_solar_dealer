import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class BlurCircle extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final double opacity;

  const BlurCircle({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    required this.opacity,
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
            color: ColorPalette.whitetext.withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}