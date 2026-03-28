import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

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
          topLeft: isFirst ? Radius.circular(s(10)) : Radius.zero,
          topRight: isFirst ? Radius.circular(s(10)) : Radius.zero,

        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: s(5), 
            sigmaY: s(5), 
          ),
          child: Container(
            height: s(70),
            width: s(400),
            padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(10)),
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withOpacity(0.50),
              border: Border.all(
                color: ColorPalette.whitetext,
                width: s(1)
              )
            ),
            child: Row(
              children: [
                /// AVATAR
                Container(
                  width: s(50),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: ColorPalette.whitetext.withOpacity(0.50),
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorPalette.whitetext),
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
                          color: ColorPalette.bottomtext,
                        ),
                      ),
                       SizedBox(height: s(4)),
                      Text(
                        "9874563212",
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin.withValues(alpha: .80),
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
                  color: ColorPalette.textfiledin.withValues(alpha: .80),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}