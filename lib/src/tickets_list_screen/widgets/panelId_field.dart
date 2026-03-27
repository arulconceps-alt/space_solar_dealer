import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              color: const Color(0xFF282828),
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: s(14)),

          /// 🔹 INPUT BOX
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
              textAlignVertical: TextAlignVertical.center, // ✅ keeps center

              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,

                // ✅ THIS is the key
                contentPadding: EdgeInsets.symmetric(
                  vertical: s(14), // adjust 13–16 based on your design
                  horizontal: s(0),
                ),

                hintStyle: GoogleFonts.lato(
                  color: const Color(0xCC484848),
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