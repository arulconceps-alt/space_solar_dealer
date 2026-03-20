
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final double scale;
  final VoidCallback onTap; // Add this line

  const ActionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    required this.scale,
    required this.onTap, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return InkWell( // Wrap the container with InkWell
      onTap: onTap,
      borderRadius: BorderRadius.circular(s(20)),
      child: Container(
        width: s(192),
        height: s(135),
        padding: EdgeInsets.all(s(16)),
        decoration: ShapeDecoration(
          color: color.withOpacity(0.12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(20))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: s(40),
              height: s(40),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(6))),
              ),
              child: Center(
                child: Image.asset(imagePath, width: s(22), height: s(22)),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.lato(
                color: const Color(0xCC484848),
                fontSize: s(15),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}