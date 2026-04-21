import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class TicketDetailsDialog extends StatelessWidget {
  const TicketDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Center(
      child: Container(
        width: s(400),
       // height: s(706),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket Details",
                  style: GoogleFonts.poppins(
                    fontSize: s(18),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.bottomtext,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/ticket/cross_icon.png",
                    width: s(12.73),
                    height: s(12.73),
                  ),
                )
              ],
            ),

            SizedBox(height: s(21)),
            Text(
              "TKT-001",
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
                color: ColorPalette.bottomtext,
              ),
            ),

            SizedBox(height: s(15)),
            Container(
              width: s(360),
              padding: EdgeInsets.symmetric(vertical: s(20), horizontal: s(16)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Column(
                children: [
                  _infoRow(
                    "assets/images/ticket/noun_profile_icon.png",
                    "Customer Name",
                    "Rohit Sharma",
                    scale,
                    24,
                    17,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/solar_panel.png",
                    "Panel ID",
                    "SS-2025-001",
                    scale,
                     28,
                     15,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/exclamation_icon.png",
                    "Issue Type",
                    "Low Power Output",
                    scale,
                     22,
                     19,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/calender_icon.png",
                    "Created Date",
                    "2025-11-14",
                    scale,
                     24,
                     18,
                  ),
                ], 
              ),
            ),

            SizedBox(height: s(16)),

            Text(
              "Technician Assigned",
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                color: ColorPalette.bottomtext,
              ),
            ),

            SizedBox(height: s(16)),

            /// 🔹 TECHNICIAN CARD
            Container(
              width: double.infinity,
              height: s(82),
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF000000).withOpacity(0.30)),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Image.asset(
                    "assets/images/ticket/gg_profile.png",
                    width: s(24),
                    height: s(24),
                  ),

                  SizedBox(width: s(13)),

                  /// NAME + DATE
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sharma",
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.bottomtext,
                          ),
                        ),
                        SizedBox(height: s(4)),
                        Text(
                          "2025-11-14",
                          style: GoogleFonts.lato(
                            fontSize: s(12),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textfiledin,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: s(100)),
                  Container(
                    width: s(98.98),
                    height: s(40),
                    decoration: BoxDecoration(
                      color: ColorPalette.background,
                      borderRadius: BorderRadius.circular(s(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Call",
                      style: GoogleFonts.poppins(
                        fontSize: s(16),
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: s(16)),

            /// 🔹 DESCRIPTION TITLE
            Text(
              "Description",
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                color: ColorPalette.bottomtext,
              ),
            ),

            SizedBox(height: s(16)),

            Container(
              width: double.infinity,
              height: s(82),
              padding: EdgeInsets.symmetric(
                horizontal: s(21),
                vertical: s(16),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF000000).withOpacity(0.30),
                  width: s(1),
                ),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Panel showing reduced efficiency after\nrecent dust storm.",
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiledin,
                  ),
                ),
              ),
            ),

            SizedBox(height: s(23)),
            Container(
              width: double.infinity,
              height: s(50),
              decoration: BoxDecoration(
                color: const Color(0xFF26A7DF),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              alignment: Alignment.center,
              child: Text(
                "View Whatsapp update",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      String icon,
      String title,
      String value,
      double scale,
      double iconsize,
      double width,
      ) {
    double s(double v) => v * scale;

    return Row(
      children: [
        Image.asset(
          icon,
          width: s(iconsize),
          height: s(iconsize),
          fit: BoxFit.contain,
          color: ColorPalette.textfiledin.withValues(alpha: .80),
        ),
    
        SizedBox(width: s(width)),
    
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: s(12),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiledin,
                ),
              ),
              SizedBox(height: s(4)),
              Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.bottomtext,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}