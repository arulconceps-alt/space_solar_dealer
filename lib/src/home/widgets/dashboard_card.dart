import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart'; // Import your palette

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color backgroundColor; // The color for the icon box
  final String imagePath;      // Path to your PNG asset
  final double scale;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.backgroundColor,
    required this.imagePath,
    required this.scale,
  });

  // Inside dashboard_card.dart
  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: s(192),
      height: s(177),
      padding: EdgeInsets.all(s(16)),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.50),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(s(20)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Change to MainAxisAlignment.spaceBetween or keep as start
        children: [
          // 1. ICON BOX
          Container(
            width: s(40),
            height: s(40),
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(6))),
            ),
            child: Center(
              child: Image.asset(imagePath, width: s(22), height: s(22)),
            ),
          ),

          // 2. THE DYNAMIC GAP
          // Using Expanded here acts like a "flexible spacer"
          // that won't cause an overflow if space is tight.
          const Expanded(child: SizedBox()),

          // 3. TITLE
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(fontSize: s(16), color: const Color(0xCC484848)),
          ),

          SizedBox(height: s(8)), // Reduced slightly from 10 to 8 to prevent overflow

          // 4. VALUE
          Text(
            value,
            style: GoogleFonts.lato(fontSize: s(18), fontWeight: FontWeight.w700),
          ),

          SizedBox(height: s(8)), // Reduced slightly

          // 5. SUBTITLE
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(fontSize: s(14), color: const Color(0xCC484848)),
          ),
        ],
      ),
    );
  }
}