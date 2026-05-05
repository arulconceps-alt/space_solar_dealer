import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrDivider extends StatelessWidget {
  final double scale;
  const OrDivider({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: s(10)),
          child: Text(
            "OR",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: s(14),
              color: const Color(0xFF484848),
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
      ],
    );
  }
}