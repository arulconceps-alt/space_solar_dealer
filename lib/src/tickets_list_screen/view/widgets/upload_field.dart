import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class UploadField extends StatelessWidget {
  final double scale;
  final VoidCallback? onTap;

  // 🔥 Added
  final List<File> files;
  final Function(int index)? onRemove;

  const UploadField({
    super.key,
    required this.scale,
    this.onTap,

    // 🔥 Added
    this.files = const [],
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Photos',
          style: GoogleFonts.lato(
            color: ColorPalette.bottomtext,
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
              width: double.infinity,
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
                    color: ColorPalette.textfiledin.withValues(alpha: .80),
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

        /// 🔥 IMAGE PREVIEW
        if (files.isNotEmpty) ...[
          SizedBox(height: s(14)),

          Wrap(
            spacing: s(10),
            runSpacing: s(10),
            children: List.generate(files.length, (index) {
              final file = files[index];

              return Stack(
                children: [
                  Container(
                    width: s(80),
                    height: s(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(s(10)),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(s(10)),
                      child: Image.file(
                        file,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// 🔥 REMOVE BUTTON
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (onRemove != null) {
                          onRemove!(index);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(s(4)),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: s(12),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ],
    );
  }
}