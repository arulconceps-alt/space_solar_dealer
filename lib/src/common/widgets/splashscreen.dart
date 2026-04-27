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
      // context.go('/total_panel_list');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double logoWidth = size.width * 0.7;
    final double logoHeight = logoWidth * (30 / 281.18);
    return Scaffold(
      backgroundColor: ColorPalette.background,
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