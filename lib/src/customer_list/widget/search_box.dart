import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class SearchBox extends StatelessWidget {
  final double scale;
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBox({
    super.key,
    required this.scale,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      height: s(50),
      width: s(400),
      padding: EdgeInsets.only(
        left: s(20),   // ✅ exact Figma
        right: s(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(width: s(1), color: Colors.white),
      ),
      child: Row(
        children: [
          /// 🔍 ICON (perfectly centered like Figma)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: s(13), // ✅ top & bottom = 13
            ),
            child: Image.asset(
              'assets/images/customer/search_icon.png',
              width: s(24),
              height: s(24),
              color: const Color(0xFF484848),
            ),
          ),

          SizedBox(width: s(9)), // ✅ tighter spacing like Figma

          /// 🔤 TEXT FIELD
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: s(16),
                color: const Color(0xFF282828),
              ),
              decoration: InputDecoration(
                hintText: "Search by Customer",
                hintStyle: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiled,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero, // ✅ IMPORTANT (fix vertical alignment)
              ),
            ),
          ),
        ],
      ),
    );
  }
}