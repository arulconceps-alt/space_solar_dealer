
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String name;
  final String status;
  final String time;
  final Color color;
  final double scale;

  const ActivityTile({
    super.key,
    required this.title,
    required this.name,
    required this.status,
    required this.time,
    required this.color,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400 * scale,
      height: 100 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.50),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(20 * scale),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.lato(fontSize: 16 * scale, fontWeight: FontWeight.w500)),
              Text(name, style: GoogleFonts.lato(fontSize: 14 * scale, color: const Color(0xCC484848))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10 * scale)),
                child: Text(status, style: TextStyle(color: Colors.white, fontSize: 10 * scale)),
              ),
              SizedBox(height: 8 * scale),
              Text(time, style: GoogleFonts.lato(fontSize: 12 * scale, color: const Color(0xCC484848))),
            ],
          ),
        ],
      ),
    );
  }
}