import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomSearchBar extends StatelessWidget {
  final double scale;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.scale,
    this.hintText = 'Search by Tickets ID, Panel ID or Customer',
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      height: s(50),
      width:s(400),
      padding: EdgeInsets.symmetric(horizontal: s(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(
          color: Colors.white,
          width: s(1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // ✅ vertical center
        children: [
          /// 🔍 ICON (Perfectly centered like Figma)
          SizedBox(
            width: s(24),
            height: s(24),
            child: Image.asset(
              'assets/images/customer/search_icon.png',
              fit: BoxFit.contain,
              color: const Color(0xFF484848),
            ),
          ),

          SizedBox(width: s(12)), // ✅ spacing from Figma

          /// ✍️ TEXT FIELD
          Expanded(
            child: Center(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style:  GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.bottomtext,
                ),
                decoration: InputDecoration(
                  isCollapsed: true, // ✅ IMPORTANT (removes extra height)
                  hintText: hintText,
                  hintStyle: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiled,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}