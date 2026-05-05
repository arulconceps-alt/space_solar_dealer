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
          child: SizedBox(
            width: s(256.99), // Updated to Figma Width
            height: s(27.42), // Updated to Figma Height
            child: SvgPicture.asset(
              "assets/images/login/logo.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}