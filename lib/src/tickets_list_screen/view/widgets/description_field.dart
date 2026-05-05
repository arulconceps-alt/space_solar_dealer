  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:space_solar_dealer/src/app/color_palette.dart';

  class DescriptionField extends StatelessWidget {
    final double scale;
    final String hint;
    final TextEditingController? controller;

    const DescriptionField({
      super.key,
      required this.scale,
      this.hint = "Describe the issue in detail",
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
              'Description*',
              style: GoogleFonts.lato(
                color: ColorPalette.bottomtext,
                fontSize: s(16),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: s(14)),

            /// 🔹 MULTILINE INPUT BOX
            Container(
              width: s(362),
              height: s(90),
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6), // Match design background
                borderRadius: BorderRadius.circular(s(10)),
              ),

              child: TextField(
                controller: controller,
                // 🔹 ADD THESE TWO LINES 🔹
                maxLines: null,
                minLines: null,

                expands: true, // ✅ fills full height
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: s(12),
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
              ),
            ),
          ],
        ),
      );
    }
  }