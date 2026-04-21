import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PanelIdItem extends StatelessWidget {
  final String id;
  final double scale;
  final bool isLast;

  const PanelIdItem({
    super.key,
    required this.id,
    required this.scale,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    // Scaling helper local to this widget
    double s(double v) => v * scale;

    return Container(
      height: s(58),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: s(16)),
      decoration: BoxDecoration(
        // Matches the divider design from your image
        border: isLast
            ? null
            : Border(
          bottom: BorderSide(
            color: ColorPalette.whitetext.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Text(
        id,
        style: GoogleFonts.lato(
          fontSize: s(16),
          fontWeight: FontWeight.w500,
          color: const Color(0xFF484848),
        ),
      ),
    );
  }
}