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
    return Text(
      text,
       style: GoogleFonts.lato(
          fontSize: scale * 16,
          fontWeight: FontWeight.w400,
          color: ColorPalette.textfiledin,
          height: 1.4,
          letterSpacing: 0,
        ),
    );
  }
}