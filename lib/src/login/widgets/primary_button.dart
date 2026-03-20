import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final double scale;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: scale * 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF26A7DF),
          foregroundColor: ColorPalette.whitetext,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: scale * 16,
            fontWeight: FontWeight.w600,
            color: ColorPalette.whitetext,
          ),
        ),
      ),
    );
  }
}