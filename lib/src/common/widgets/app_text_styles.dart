import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    color: ColorPalette.bottomtext,
    fontSize: 16,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleScaled(double scale) => TextStyle(
    color: ColorPalette.textfiledin,
    fontSize: 16 * scale,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w600,
  );

 /// description
  static TextStyle descriptionScaled(double scale) => TextStyle(
    color: ColorPalette.textfiledin,
    fontSize: 16 * scale,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
  );
  ///button text
  static TextStyle buttonScaled(double scale) => TextStyle(
    color: const Color(0xFFFFFFFF),
    fontSize: 16 * scale,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 1.06,
  );

  /// onboarding text font style
  static TextStyle onboarding() => TextStyle(
    color: const Color(0xFFFFFFFF),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,

  );
  ///Login heading
  static TextStyle headingScaled(double scale) => TextStyle(
    color: const Color(0xFF282828),
    fontSize: 32 * scale,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 1.19,
  );
  ///Login subheading
  static TextStyle subheadingScaled(double scale) => TextStyle(
    color: const Color(0xFF484848),
    fontSize: 16,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    height: 1.40,
  );
  ///Label text heading
  static TextStyle labelTextHeadScaled(double scale) => TextStyle(
    color: const Color(0xFF484848),
    fontSize: 16,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    height: 1.40,
  );
  /// continue text fonts
  static TextStyle centerTextScaled(double scale) => TextStyle(
    color: const Color(0xFF1E1E1E),
    fontSize: 12,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
  );
  static TextStyle dashTitle() => TextStyle(
    color: const Color(0xFF282828),
    fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,

  );


  static final heading = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF282828),
  );

  static final sectionTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF282828),
  );


  static final cardTitle = GoogleFonts.lato(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: const Color(0xCC484848),
  );

  static final cardValue = GoogleFonts.lato(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: const Color(0xFF282828),
  );

  static final cardSubtitle = GoogleFonts.lato(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: const Color(0xCC484848),
  );

}

