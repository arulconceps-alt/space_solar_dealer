import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class NotificationTitle extends StatelessWidget {
  final double scale;

  const NotificationTitle({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Text(
      "Notification",
      style: GoogleFonts.poppins(
        fontSize: s(20),
        fontWeight: FontWeight.w600,
        color: ColorPalette.bottomtext,
      ),
    );
  }
}