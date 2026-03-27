import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class ProfileHeader extends StatelessWidget {
  final double scale;

  const ProfileHeader({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
     final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: s(20),
            fontWeight: FontWeight.w600,
            height: 1,
            color: ColorPalette.bottomtext,
          ),
        ),
        SizedBox(height: s(4)),
        Text(
          "Dealer Information",
          style: GoogleFonts.lato(
            fontSize: s(14),
            height: 1,
            fontWeight: FontWeight.w400,
            color: ColorPalette.textfiledin.withValues(alpha: .80),
          ),
        ),
      ],
    );
  }
}