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
    final screenWidth = MediaQuery.of(context).size.width;

    final double logoWidth = screenWidth * (281.18 / 390);
    final double logoHeight = logoWidth * (30 / 281.18);

    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            iconLogo,
            width: logoWidth,
            height: logoHeight,
          ),
        ),
      ),
    );
  }
}