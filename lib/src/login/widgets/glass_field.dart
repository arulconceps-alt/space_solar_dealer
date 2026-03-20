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
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.lato(
        fontSize: scale * 16,
        color: ColorPalette.textfiledin, // #484848
        height: 1.4,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.lato(
          fontSize: scale * 16,
          color: ColorPalette.textfiledin.withOpacity(0.7),
        ),

        suffixIcon: suffix,

        filled: true,
        fillColor: Colors.white, // ✅ solid white like figma

        contentPadding: EdgeInsets.symmetric(
          horizontal: scale * 16,
          vertical: scale * 14, // keeps vertical center perfect
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: ColorPalette.bordertextbox, // #E2E2E2
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: ColorPalette.bordertextbox,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xFF26A7DF), // blue focus (figma)
            width: 1,
          ),
        ),
      ),
    );
  }
}