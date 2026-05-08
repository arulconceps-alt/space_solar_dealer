import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color backgroundColor;
  final String imagePath;
  final double iconSize;
  final String route;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.backgroundColor,
    required this.imagePath,
    required this.route,
    this.iconSize = 24,
  });

  double _getPadding(double iconSize) {
    if (iconSize >= 28) return 6;
    if (iconSize >= 24) return 8;
    return 9;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return GestureDetector(
      onTap: () {
        if (route.isNotEmpty) {
          context.goNamed(route);
        }
      },
      child: Container(
        padding: EdgeInsets.all(s(16)),
        decoration: ShapeDecoration(
          color: ColorPalette.whitetext.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: s(1), color: ColorPalette.whitetext),
            borderRadius: BorderRadius.circular(s(20)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: s(40),
              height: s(40),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(s(6)),
              ),
              child: Padding(
                padding: EdgeInsets.all(s(_getPadding(iconSize))),
                child: Image.asset(
                  imagePath,
                  width: s(iconSize),
                  height: s(iconSize),
                ),
              ),
            ),

            SizedBox(height: s(12)),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.textfiledin.withOpacity(0.80),
                ),
              ),
            ),

            SizedBox(height: s(8)),

            Text(
              value,
              style: GoogleFonts.lato(
                fontSize: s(18),
                fontWeight: FontWeight.w500,
                color: ColorPalette.bottomtext,
              ),
            ),

            if (subtitle.isNotEmpty) ...[
              SizedBox(height: s(8)),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle,
                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.textfiledin.withOpacity(0.80),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}