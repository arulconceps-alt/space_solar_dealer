import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerItem extends StatelessWidget {
  final String name;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const CustomerItem({
    super.key,
    required this.name,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(s(12)) : Radius.zero,
          topRight: isFirst ? Radius.circular(s(12)) : Radius.zero,

        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: s(5), // ✅ scaled
            sigmaY: s(5), // ✅ scaled
          ),
          child: Container(
            height: s(70),
            width: s(400),
            padding: EdgeInsets.symmetric(horizontal: s(12)),
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
                /// AVATAR
                Container(
                  width: s(50),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    name[0],
                    style: GoogleFonts.lato(
                      fontSize: s(24),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),

                SizedBox(width: s(12)),

                /// TEXT
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.lato(
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF282828),
                        ),
                      ),
                      Text(
                        "9874563212",
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF282828),
                        ),
                      ),
                    ],
                  ),
                ),

                /// MENU ICON
                Image.asset(
                  "assets/images/customer/three_dots_icon.png",
                  width: s(23.9),
                  height: s(23.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}