
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';

class SuccessDialog extends StatelessWidget {
  final double scale;
  const SuccessDialog({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: s(400),
      height: s(538.56),
      padding: EdgeInsets.symmetric(horizontal: s(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(color: Colors.white, width: s(1)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: s(34)),

          /// 🔹 TOP ICON
          Container(
            width: s(110),
            height: s(110),
            decoration: const BoxDecoration(
              color: Color(0x4C319F43),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/success/tick_circle_outline.png",
                width: s(44),
                height: s(44),
              ),
            ),
          ),

          SizedBox(height: s(26)),

          /// 🔹 TITLE
          Text(
            "Registered!",
            style: GoogleFonts.poppins(
              fontSize: s(18),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF282828),
            ),
          ),

          SizedBox(height: s(40)),

          /// 🔹 PANEL ID
          Text(
            "Panel ID : SS-00120",
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xCC484848),
            ),
          ),

          SizedBox(height: s(41)),

          /// 🔹 DESCRIPTION
          Text(
            "Confirmation sent via SMS & Whatsapp to\ncustomer",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xCC484848),
            ),
          ),

          SizedBox(height: s(55)),

          /// 🔹 PRIMARY BUTTON
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // close dialog
              // optional: navigate
            },
            child: Container(
              width: double.infinity,
              height: s(50),
              decoration: BoxDecoration(
                color: const Color(0xFF26A7DF),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              alignment: Alignment.center,
              child: Text(
                "Register Another Customer",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: s(16)),

          /// 🔹 OUTLINE BUTTON
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // ✅ close dialog first
              context.goNamed(RouteName.home); // ✅ go to dashboard
            },
            child: Container(
              width: double.infinity,
              height: s(50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(s(10)),
                border: Border.all(
                  color: const Color(0x33484848),
                  width: s(1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Back to Home",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF484848),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}