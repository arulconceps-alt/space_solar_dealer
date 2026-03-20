import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [
          // 1. Background Blurred Circles
          _buildBlurredCircle(298, 44, 383, Colors.white.withOpacity(0.4), scale, 60),
          _buildBlurredCircle(-187, 716, 383, Colors.white.withOpacity(0.5), scale, 40),
          _buildBlurredCircle(-146, -201, 383, Colors.white, scale, 50),

          SafeArea(
            child: Column(
              children: [
                // 2. Header (No back arrow passed)
                TopHeaderCard(
                  scale: scale,
                  notificationCount: "16",
                ),

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                      child: _buildSuccessCard(context,scale),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard(BuildContext context,double scale) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40 * scale, horizontal: 20 * scale),
      decoration: BoxDecoration(
        // Matching the white glassmorphism effect from your Figma
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- GREEN SUCCESS CIRCLE WITH IMAGE ---
          Container(
            width: 110 * scale,
            height: 110 * scale,
            decoration: const BoxDecoration(
              // Updated to the exact light green from your image
              color: Color(0x4C319F43),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/success/tick_circle_outline.png", // Replace with your actual path
                width: 44 * scale,
                height: 44 * scale,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 24 * scale),

          Text(
            'Registered!',
            style: GoogleFonts.poppins(
              color: const Color(0xFF282828),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16 * scale),

          Text(
            'Panel ID : SS-00120',
            style: GoogleFonts.lato(
              color: const Color(0xCC484848),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30 * scale),

          Text(
            'Confirmation sent via SMS & Whatsapp to\ncustomer',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: const Color(0xCC484848),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40 * scale),

          // Primary Button: Register Another
          _buildActionButton(
            text: 'Register Another Customer',
            color: const Color(0xFF26A7DF),
            textColor: Colors.white,
            scale: scale,
            onPressed: () {
              context.pushReplacementNamed(RouteName.customer_register);
            },
          ),
          SizedBox(height: 15 * scale),

          // Outline Button: Back to Home
          _buildActionButton(
            text: 'Back to Home',
            color: Colors.transparent,
            textColor: const Color(0xFF484848),
            isOutline: true,
            scale: scale,
            onPressed: () {
              // Navigate back to Home using GoRouter
              context.goNamed(RouteName.home);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required Color textColor,
    required double scale,
    required VoidCallback onPressed,
    bool isOutline = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50 * scale,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10 * scale),
          border: isOutline ? Border.all(color: const Color(0x33484848)) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlurredCircle(double left, double top, double size, Color color, double scale, double blur) {
    return Positioned(
      left: left * scale,
      top: top * scale,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: size * scale,
          height: size * scale,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}