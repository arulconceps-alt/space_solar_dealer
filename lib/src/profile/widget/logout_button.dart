import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class LogoutButton extends StatelessWidget {
  final double scale;

  const LogoutButton({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: s(40),
        width: s(146),
        padding: EdgeInsets.symmetric(horizontal: s(26), vertical: s(8)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext.withOpacity(0.5),
          borderRadius: BorderRadius.circular(s(10)),
          border: Border.all(color: ColorPalette.whitetext),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile/logout.png",
              width: s(24),
              height: s(24),
            ),
            SizedBox(width: s(10)),
            Text(
              "Logout",
              style: GoogleFonts.poppins(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                color: ColorPalette.textfiledin.withValues(alpha: .80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}