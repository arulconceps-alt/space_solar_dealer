import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double scale;

  const LogoWidget({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
     double s(double v) => v * scale;
    return  SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: s(74),
        child: Row(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            SizedBox(
              width: s(192.75),
              height: s(20.56),
              child: SvgPicture.asset(
                "assets/images/login/logo.svg",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}