import 'package:flutter/material.dart';
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
}