import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';

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

    return SizedBox(
      width: s(360),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 LABEL
          Text(
            'Upload Photo/Videos',
            style: GoogleFonts.lato(
              color: const Color(0xFF282828),
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: s(14)),

          /// 🔹 DOTTED BORDER BOX
          GestureDetector(
            onTap: onTap,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: const Color(0xFFBDBDBD),
                strokeWidth: s(1.5),
                dashPattern: const [6, 4],
                radius: Radius.circular(s(12)),
              ),
              child: Container(
                width: s(360),
                height: s(129),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    ),

                    SizedBox(height: s(8)),

                    /// TEXT
                    Text(
                      'Click to Upload Invoice',
                      style: GoogleFonts.lato(
                        color: const Color(0xFF484848),
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
      ),
    );
  }
}