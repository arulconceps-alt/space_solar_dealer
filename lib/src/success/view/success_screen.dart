import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../app/color_palette.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    /// Top spacing (Figma 102)
                    const SizedBox(height: 102),
                    /// SUCCESS ICON
                    SvgPicture.asset(
                      "assets/images/auth/icon_check.svg",
                      width: 211,
                      height: 230,
                      colorFilter: const ColorFilter.mode(
                        ColorPalette.primary,
                        BlendMode.srcIn,
                      ),
                    ),

                    const SizedBox(height: 43),

                    /// TITLE
                    const Text(
                      "Congratulations!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorPalette.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "You have successfully completed the onboarding",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorPalette.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// CONTINUE BUTTON
                    GestureDetector(
                      onTap: () {
                        context.go("/home");
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: ColorPalette.primaryGradient,
                          borderRadius: BorderRadius.circular(9.58),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.77,
                            fontWeight: FontWeight.w600,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}