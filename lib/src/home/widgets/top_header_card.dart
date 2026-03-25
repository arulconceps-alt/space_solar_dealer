import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopHeaderCard extends StatelessWidget {
  final double scale;
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationTap; // added
  final String notificationCount;
  final bool showNotification;

  const TopHeaderCard({
    super.key,
    required this.scale,
    this.onBackTap,
    this.onNotificationTap,
    this.notificationCount = "16",
    required this.showNotification,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: double.infinity,
      height: s(134),
      padding: EdgeInsets.only(
        left: s(20),
        right: s(20),
        top: s(90),
        bottom: s(27),// same baseline
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0x3326A7DF)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// LEFT - BACK ARROW
          SizedBox(
            width: s(24),
            height: s(24),
            child: onBackTap != null
                ? GestureDetector(
              onTap: onBackTap,
              child: Image.asset(
                "assets/images/new_register/back_arrow.png",
                fit: BoxFit.contain,
              ),
            )
                : const SizedBox(),
          ),

          /// CENTER - LOGO
          Expanded(
            child: Center(
              child: SizedBox(
                width: s(192),
                height: s(24),
                child: SvgPicture.asset(
                  "assets/images/login/logo.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          /// RIGHT - NOTIFICATION
          GestureDetector(
            onTap: onNotificationTap,
            child: SizedBox(
              width: s(24),
              height: s(24),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/images/home/notification.svg",
                    height: s(24),
                    width: s(24),
                  ),

                  /// BADGE
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
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}