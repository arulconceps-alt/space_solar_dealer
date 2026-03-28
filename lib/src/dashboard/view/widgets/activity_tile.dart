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

    Color bgColor;
    Color textColor;

    if (status == "Completed") {
      bgColor = const Color(0xFF4A4A4A);  
      textColor = const Color(0xFFF2F2F2);
    } else {
      bgColor = statusColor.withOpacity(0.15); 
      textColor = statusColor; 
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: s(16)),
      padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(28)),
      decoration: BoxDecoration(
        color: ColorPalette.whitetext.withOpacity(0.50),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(width: s(1), color: ColorPalette.whitetext),
      ),
      child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    /// LEFT SIDE
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
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
            color: ColorPalette.textfiledin.withValues(alpha: .80),
          ),
        ),
      ],
    ),

    const Spacer(),

    /// RIGHT SIDE
    Column(
      crossAxisAlignment: CrossAxisAlignment.end, 
      children: [
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

        Text(
          time,
          style: GoogleFonts.lato(
            fontSize: s(14),
            fontWeight: FontWeight.w400,
            color: ColorPalette.textfiled.withValues(alpha: .80),
          ),
        ),
      ],
    )
  ],
),
    );
  }
}