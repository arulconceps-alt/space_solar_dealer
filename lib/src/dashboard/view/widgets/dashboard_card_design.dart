import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color backgroundColor;
  final String imagePath;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.backgroundColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.all(s(16)),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: s(1), color: Colors.white),
          borderRadius: BorderRadius.circular(s(20)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: s(40),
            height: s(40),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(s(6)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                imagePath,
                width: s(28),
                height: s(28),
              ),
            ),
          ),

          SizedBox(height: s(23)),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              maxLines: 1,
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: ColorPalette.textfiledin,
              ),
            ),
          ),

          SizedBox(height: s(10)),

          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: s(18),
              fontWeight: FontWeight.w500,
              color: ColorPalette.bottomtext// 👈 optional scaling
            ),
          ),

          SizedBox(height: s(10)),

          Text(
            subtitle,
            style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w500,
                height: s(1),
                color: ColorPalette.textfiledin// 👈 optional scaling (safe)
            ),
          ),
        ],
      ),
    );
  }
}