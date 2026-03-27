import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class ActivityCard extends StatelessWidget {
  final String title, name, time, status;
  final Color statusColor;

  const ActivityCard({
    super.key,
    required this.title,
    required this.name,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    /// 🔥 STATUS COLORS (based on your Figma)
    Color bgColor;
    Color textColor;

    if (status == "Completed") {
      bgColor = const Color(0xFF4A4A4A);   // dark grey
      textColor = const Color(0xFFF2F2F2); // light text
    } else {
      bgColor = statusColor.withOpacity(0.15); // default light bg
      textColor = statusColor; // full color text
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: s(12)),
      padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(width: s(1), color: Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.bottomtext,
                  ),
                ),

                SizedBox(height: s(8)),

                Text(
                  name,
                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xCC484848),
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// STATUS BADGE
              Container(
                width: s(74),
                height: s(20),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Center(
                  child: Text(
                    status,
                    style: GoogleFonts.lato(
                      fontSize: s(10),
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: s(6)),

              /// TIME
              Text(
                time,
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiled,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}