import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final double scale;
  final VoidCallback onTap;

  const BlueButton({super.key, required this.text, required this.scale, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;
    return Material(
      color: const Color(0xFF26A7DF),
      borderRadius: BorderRadius.circular(s(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(s(10)),
        child: Container(
          height: s(50),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: s(16), fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}