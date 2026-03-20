import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopHeaderCard extends StatelessWidget {
  final double scale;
  final VoidCallback? onBackTap;
  final String notificationCount;

  const TopHeaderCard({
    super.key,
    required this.scale,
    this.onBackTap,
    this.notificationCount = "16", // Defaulting to 16 as per your design
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    // This baseline ensures all items (Arrow, Logo, Bell) are at the same Y-axis
    final double topBaseline = s(90);

    return Container(
      width: double.infinity,
      height: s(134),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0x3326A7DF))),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// 1. BACK ARROW IMAGE (Left Aligned)
          if (onBackTap != null)
            Positioned(
              left: s(20),
              top: topBaseline,
              child: GestureDetector(
                onTap: onBackTap,
                child: Image.asset(
                  "assets/images/new_register/back_arrow.png", // Use your image path
                  height: s(24),
                  width: s(24),
                  fit: BoxFit.contain,
                ),
              ),
            ),

          /// 2. LOGO (Centered Horizontally)
          Positioned(
            left: 0,
            right: 0,
            top: topBaseline,
            child: Center(
              child: SizedBox(
                width: s(192),
                height: s(24), // Set height same as icons for perfect alignment
                child: SvgPicture.asset(
                  "assets/images/login/logo.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          /// 3. NOTIFICATION ICON + BADGE (Right Aligned)
          Positioned(
            right: s(20),
            top: topBaseline,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  "assets/images/home/notification.svg",
                  height: s(24),
                  width: s(24),
                  fit: BoxFit.contain,
                ),

                // --- NOTIFICATION BADGE ---
                Positioned(
                  right: s(-4),
                  top: s(-4),
                  child: Container(
                    padding: EdgeInsets.all(s(2)),
                    constraints: BoxConstraints(
                      minWidth: s(16),
                      minHeight: s(16),
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEA1F27),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        notificationCount,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: s(9),
                          fontWeight: FontWeight.bold,
                          height: 1.1, // Adjusts text position inside circle
                        ),
                      ),
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
}