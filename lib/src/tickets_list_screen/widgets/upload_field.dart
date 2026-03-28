import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class UploadField extends StatelessWidget {
  final double scale;
  final VoidCallback? onTap;

  const UploadField({
    super.key,
    required this.scale,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Photo/Videos',
          style: GoogleFonts.lato(
            color:  ColorPalette.bottomtext,
            fontSize: s(16),
            fontWeight: FontWeight.w600,
          ),
        ),
    
        SizedBox(height: s(14)),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: const Color(0xFFBDBDBD),
              strokeWidth: s(1.3),
              dashPattern: const [6, 6],
              radius: Radius.circular(s(12)),
            ),
            child: Container(
              width: s(360),
              height: s(129),
              decoration: BoxDecoration(
                color: ColorPalette.whitetext,
                borderRadius: BorderRadius.circular(s(12)),
              ),
    
              /// 🔹 CENTER CONTENT
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// ICON
                  Image.asset(
                    "assets/images/ticket/upload_icon.png",
                    width: s(30),
                    height: s(30),
                    color: ColorPalette.textfiledin.withValues(alpha: .80)
                  ),
    
                  SizedBox(height: s(6)),
    
                  /// TEXT
                  Text(
                    'Click to Upload Invoice',
                    style: GoogleFonts.lato(
                      color: ColorPalette.textfiledin,
                      fontSize: s(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}