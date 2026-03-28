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
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;
    return ClipRRect(
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
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: ColorPalette.textfiledin,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.lato(
              fontSize:  s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.textfiledin.withOpacity(0.7),
            ),
    
            suffixIcon: suffix,
  
            filled: true,
            fillColor: Colors.white.withOpacity(0.45),
    
            contentPadding: EdgeInsets.symmetric(
              horizontal:  s(16),
              vertical:  s(14),
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
                color: ColorPalette.background,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}