import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class GlassField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double scale;
  final bool obscure;
  final Widget? suffix;

  const GlassField({
    super.key,
    required this.controller,
    required this.hint,
    required this.scale,
    this.obscure = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scale * 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.lato(
              fontSize: scale * 16,
              color: ColorPalette.textfiledin,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                fontSize: scale * 16,
                color: ColorPalette.textfiledin.withOpacity(0.7),
              ),

              suffixIcon: suffix,

              /// 🔥 GLASS EFFECT
              filled: true,
              fillColor: Colors.white.withOpacity(0.45),

              contentPadding: EdgeInsets.symmetric(
                horizontal: scale * 16,
                vertical: scale * 14,
              ),

              /// BORDER
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.6),
                  width: 1,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.6),
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFF26A7DF),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}