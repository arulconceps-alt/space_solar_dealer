import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PanelIdField extends StatelessWidget {
  final double scale;
  final String hint;
  final TextEditingController? controller;

  const PanelIdField({
    super.key,
    required this.scale,
    this.hint = "Enter Panel ID",
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return SizedBox(
      width: s(362),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 LABEL
          Text(
            'Panel ID*',
            style: GoogleFonts.lato(
              color: ColorPalette.bottomtext,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: s(14)),

          Container(
            width: s(362),
            height: s(50),
            padding: EdgeInsets.symmetric(horizontal: s(16)),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(s(10)),
            ),

            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center, 

              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: s(14),
                  horizontal: s(0),
                ),

                hintStyle: GoogleFonts.lato(
                  color: ColorPalette.textfiledin.withValues(alpha: .80),
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                ),
              ),

              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
              ),
            )
          ),
        ],
      ),
    );
  }
}