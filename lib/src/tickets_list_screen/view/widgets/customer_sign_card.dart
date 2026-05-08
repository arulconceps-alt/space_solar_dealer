import 'dart:ui' as BorderType;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomerSignatureCard extends StatelessWidget {
  final String signatureImage;
  final double scale;

  const CustomerSignatureCard({
    super.key,
    required this.signatureImage,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      height: s(279),
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Signature',
            style: GoogleFonts.poppins(
              fontSize: s(16),
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: s(14)),

          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(s(12)),
              dashPattern: const [6, 4],
              strokeWidth: 1,
              color: Colors.grey.shade300,
            ),
            child: Container(
              height: s(200),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(s(14)),
                child: Center(
                  child: Text(
                    'Customer Signature',
                    style: GoogleFonts.poppins(
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                     color: ColorPalette.textfiledin,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
