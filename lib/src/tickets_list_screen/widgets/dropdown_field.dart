import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownField extends StatelessWidget {
  final double scale;
  final String hint;
  final String? value;
  final VoidCallback? onTap;

  const DropdownField({
    super.key,
    required this.scale,
    this.hint = "Select issue type",
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return SizedBox(
      width: s(362),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 LABEL
          Text(
            'Select Issue type*',
            style: GoogleFonts.lato(
              color: const Color(0xFF282828),
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: s(14)),

          /// 🔹 DROPDOWN BOX
          GestureDetector(
            onTap: onTap, // 👉 open dropdown
            child: Container(
              width: s(362),
              height: s(50),
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(s(10)),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 🔹 TEXT / VALUE
                  Text(
                    value ?? hint,
                    style: GoogleFonts.lato(
                      color: value == null
                          ? const Color(0xCC484848)
                          : const Color(0xFF282828),
                      fontSize: s(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  /// 🔹 DROPDOWN ICON
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: s(24),
                    color: const Color(0xFF484848),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}