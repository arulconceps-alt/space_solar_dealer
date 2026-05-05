import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String iconLogo = "assets/images/splash/KRG.png";

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

    final w = size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Center(
        child: Image.asset(
          iconLogo,
          width: s(125),
          height: s(113),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}