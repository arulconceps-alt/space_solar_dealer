import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String iconLogo = "assets/images/auth/logo.svg";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go('/onboarding'); // navigate after splash
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Scale the logo based on screen width (responsive)
    // Assuming Figma frame width is 390 px and logo 110 px
    final double logoSize = screenWidth * (110 / 390);

    return Scaffold(
      backgroundColor: ColorPalette.background, // Figma background
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            iconLogo,
            width: logoSize,
            height: logoSize,
            colorFilter: ColorFilter.mode(
              ColorPalette.primary, // gold accent from palette
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
