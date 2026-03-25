import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String iconLogo = "assets/images/splash/logo.png";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Use the full screen width for the logo scale
    final double logoWidth = size.width * 0.7;

    // Maintain your specific aspect ratio (30 / 281.18)
    final double logoHeight = logoWidth * (30 / 281.18);

    return Scaffold(
      backgroundColor: ColorPalette.background,
      // Removing SafeArea ensures the Center widget
      // uses the 100% height of the physical screen.
      body: Center(
        child: Image.asset(
          iconLogo,
          width: logoWidth,
          height: logoHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}