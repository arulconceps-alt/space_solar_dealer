import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class SignupGlassField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double scale;
  final bool obscure;
  final Widget? suffix;

  const SignupGlassField({
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
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: scale * 16,
              color: ColorPalette.textfiledin,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                color: const Color(0xCC484848),
                fontSize: scale * 16,
                fontWeight: FontWeight.w400,
              ),

              suffixIcon: suffix,

              filled: true,
              fillColor: ColorPalette.whitetext.withOpacity(0.50),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: ColorPalette.whitetext,
                  width: 1,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: ColorPalette.whitetext,
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

              contentPadding: EdgeInsets.symmetric(
                horizontal: scale * 16,
                vertical: scale * 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}