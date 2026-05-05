import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class NotificationCard extends StatelessWidget {
  final double scale;
  final String title;
  final String desc;
  final bool isNew;

  const NotificationCard({
    super.key,
    required this.scale,
    required this.title,
    required this.desc,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Center(
      child: Stack(
        children: [
          /// CARD
          Container(
            width: s(400),
            height: s(121.99),
            margin: EdgeInsets.only(bottom: s(16)),
            padding: EdgeInsets.all(s(16)),
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withValues(alpha: .50),
              borderRadius: BorderRadius.circular(s(20)),
              border: Border.all(
                color: ColorPalette.whitetext,
                width: s(1),
              ),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// icon box
                Container(
                  width: s(50),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: ColorPalette.whitetext,
                    borderRadius: BorderRadius.circular(s(6)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(s(13)),
                    child: Image.asset(
                      "assets/images/notification/notepad_icon.png",
                      width: s(24),
                  height: s(24),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(width: s(17)),

                /// text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.bottomtext,
                        ),
                      ),
                      SizedBox(height: s(6)),
                      Text(
                        desc,
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin
                              .withValues(alpha: 0.80),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isNew)
            SizedBox(
              width: s(400),
              height: s(121),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(
                    top: s(12),
                    right: s(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: s(10),
                    vertical: s(2),
                  ),
                  decoration: BoxDecoration(
                    color: ColorPalette.notificationstatusback,
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  child: Text(
                    "New",
                    style: GoogleFonts.lato(
                      fontSize: s(10),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.notificationstatus,
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