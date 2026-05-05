import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double scale;
  final VoidCallback? onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;
    return SizedBox(
      width: double.infinity,
      height: s(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.background,
          foregroundColor: ColorPalette.whitetext,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: s(16),
            fontWeight: FontWeight.w600,
            color: ColorPalette.whitetext,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
