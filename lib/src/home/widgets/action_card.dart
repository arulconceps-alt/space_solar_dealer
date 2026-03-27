import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final VoidCallback onTap;
  final String? arrowSvgPath;

  const ActionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    required this.onTap,
    this.arrowSvgPath,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s(20)),
      child: Container(
        height: s(135),
        width: s(192),
        padding: EdgeInsets.all(s(16)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(s(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// 🔵 ICON (top-left)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: s(40),
                height: s(40),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(s(6)),
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: s(22),
                    height: s(22),
                  ),
                ),
              ),
            ),
            SizedBox(height: s(17)),
            /// 📝 TITLE (bottom-left)
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style:GoogleFonts.lato(
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: ColorPalette.textfiled,
                    ),
                  ),
                  SvgPicture.asset(
                    arrowSvgPath!,
                    width: s(16),
                    height: s(16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}