
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/profile/view/widget/profile_toggle.dart';


class ActiveStatusCard extends StatelessWidget {
    final double scale;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const ActiveStatusCard({
    super.key,
    required this.scale,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.symmetric(horizontal:  s(16), vertical: s(24)),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color:   ColorPalette.whitetext.withValues(alpha: .50), 
        borderRadius: BorderRadius.circular( s(20)),
        border: Border.all(color: ColorPalette.whitetext),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Status",
                style: GoogleFonts.poppins(
                  fontSize: s(18),
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.bottomtext,
                ),
              ),
              Text(
                "Toggle your availability for works",
                style: GoogleFonts.poppins(
                  fontSize:  s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiledin.withValues(alpha: .80),
                ),
              ),
            ],
          ),

          /// Switch
            ProfileToggle(
              value: isActive,
              onChanged: onToggle,
              s: s,
            ),
        ],
      ),
    );
  }
}