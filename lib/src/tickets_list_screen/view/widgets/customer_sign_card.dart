import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomerSignatureCard extends StatelessWidget {
  final String? signatureImage;
  final double scale;

  const CustomerSignatureCard({
    super.key,
    required this.signatureImage,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    final hasSignature =
        signatureImage != null && signatureImage!.trim().isNotEmpty;

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

          // ── Signature image or empty dotted box ───────────────────────
          hasSignature
              ? // ── Signature area (always dotted border) ───────────────────────
DottedBorder(
  options: RoundedRectDottedBorderOptions(
    radius: Radius.circular(s(12)),
    dashPattern: const [6, 4],
    strokeWidth: 1,
    color: Colors.grey.shade300,
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(s(12)),
    child: Container(
      height: s(200),
      width: double.infinity,
      child: hasSignature
          ? CachedNetworkImage(
              imageUrl: signatureImage!,
              fit: BoxFit.contain,
              placeholder: (_, __) => Container(
                color: Colors.grey.shade100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey.shade100,
                alignment: Alignment.center,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey,
                  size: s(32),
                ),
              ),
            )
          : Center(
              child: Text(
                'No Signature',
                style: GoogleFonts.poppins(
                  fontSize: s(12),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiledin,
                ),
              ),
            ),
    ),
  ),
)
              : DottedBorder(
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
                    child: Center(
                      child: Text(
                        'No Signature',
                        style: GoogleFonts.poppins(
                          fontSize: s(12),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin,
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