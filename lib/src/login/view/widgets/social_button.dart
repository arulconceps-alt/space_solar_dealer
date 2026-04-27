import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class SocialButton extends StatelessWidget {
  final double scale;
  final Widget child;

  const SocialButton({
    super.key,
    required this.scale,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: s(60),
          height: s(60),
          decoration: BoxDecoration(
            color: ColorPalette.whitetext.withOpacity(0.50),
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.whitetext,
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}