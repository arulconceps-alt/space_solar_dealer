
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomerItem extends StatelessWidget {
  final String name;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap; // ✅ ADD THIS

  const CustomerItem({
    super.key,
    required this.name,
    required this.onTap, // ✅ REQUIRED
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 440;

    return GestureDetector( // ✅ CLICKABLE
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: isFirst ? Radius.circular(12 * scale) : Radius.zero,
            topRight: isFirst ? Radius.circular(12 * scale) : Radius.zero,
            bottomLeft: isLast ? Radius.circular(12 * scale) : Radius.zero,
            bottomRight: isLast ? Radius.circular(12 * scale) : Radius.zero,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 72 * scale,
              padding: EdgeInsets.symmetric(horizontal: 12 * scale),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                border: Border(
                  top: isFirst
                      ? BorderSide(color: Colors.white.withOpacity(0.6))
                      : BorderSide.none,
                  left: BorderSide(color: Colors.white.withOpacity(0.6)),
                  right: BorderSide(color: Colors.white.withOpacity(0.6)),
                  bottom: BorderSide(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              child: Row(
            children: [
              /// Avatar
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                alignment: Alignment.center,
                child: Text(
                  name[0],
                  style: GoogleFonts.lato(
                    fontSize: 22 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lato(
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF282828),
                      ),
                    ),
                    Text(
                      "9874563212",
                      style: GoogleFonts.lato(
                        fontSize: 13 * scale,
                        color: const Color(0xFF484848).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/customer/three_dots_icon.png",
                width: 20 * scale,
                height: 20 * scale,
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}