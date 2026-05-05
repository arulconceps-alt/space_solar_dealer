import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double scale;

  const LogoWidget({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: s(60)),
        child: Center(
          child: Image.asset(
            "assets/images/login/KRG.png",
                 width: s(111), // Updated to Figma Width
            height: s(100), // Updated to Figma Height
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}