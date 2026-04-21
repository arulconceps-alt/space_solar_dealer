import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class FieldLabel extends StatelessWidget {
  final String text;
  final double scale;

  const FieldLabel({
    super.key,
    required this.text,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return Text(
      text,
       style: GoogleFonts.lato(
          fontSize: s(16),
          fontWeight: FontWeight.w400,
          color: ColorPalette.textfiledin,
          letterSpacing: 0,
        ),
    );
  }
}