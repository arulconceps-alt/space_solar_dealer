import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class GlassField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double scale;
  final bool obscure;
  final Widget? suffix;
  final FocusNode? focusNode;

  const GlassField({
    super.key,
    required this.controller,
    required this.hint,
    required this.scale,
    this.obscure = false,
    this.suffix,
    this.focusNode,
  });


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return ClipRRect(
      borderRadius: BorderRadius.circular(s(8)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: TextField(
          controller: controller,
          autofocus: true,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          cursorColor: ColorPalette.background,
          cursorWidth: 1.5,
          textAlignVertical: TextAlignVertical.center,
          // 1. TYPED TEXT STYLE: Change from white to Dark Grey/Black
          style: GoogleFonts.lato(
            color: ColorPalette.textfiled, // Figma uses a dark grey for input
            fontSize: 16,
            fontWeight: FontWeight.w400, // Medium weight looks better for numbers
            letterSpacing: 1.0,
            height: 1.0,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            // 2. FILL COLOR: Increased opacity for that "milky" glass look
            fillColor: Colors.white.withOpacity(0.5),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: s(16)),
                Image.asset(
                  'assets/images/login/india_flag.png',
                  width: s(24),
                  height: s(24),
                ),
                SizedBox(width: s(8)),
                Text(
                  '+91',
                  style: GoogleFonts.lato(
                    color: ColorPalette.textfiled, // Prefix is lighter than input
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // 3. THE GAP: This creates the 97px total width for the prefix area
                SizedBox(width: s(28)),
              ],
            ),
            contentPadding: EdgeInsets.only(top: s(21), bottom: s(19)),
            // 4. BORDER: Solid white with low opacity
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s(8)),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7), width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s(8)),
              borderSide: const BorderSide(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}