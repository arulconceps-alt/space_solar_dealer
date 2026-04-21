
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final double scale;
  final bool isAddress;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.scale,
    this.isAddress = false,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w600,
            color: ColorPalette.bottomtext,
          ),
        ),
        SizedBox(height: s(14)),
        Container(
          height: isAddress ? s(74) : s(50),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s(16)),
            child: TextField(
              maxLines: isAddress ? 3 : 1,
              textAlignVertical: isAddress ? TextAlignVertical.top : TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: s(16)),
                hintStyle: GoogleFonts.lato(
                  color: const Color(0xCC484848).withOpacity(0.80),
                  fontSize: s(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}