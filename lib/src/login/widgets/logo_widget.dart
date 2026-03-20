import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double scale;

  const LogoWidget({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: scale * 192.7461,
      height: scale * 20.5644,
      child: SvgPicture.asset(
        "assets/images/login/logo.svg",
        fit: BoxFit.contain,
      ),
    );
  }
}