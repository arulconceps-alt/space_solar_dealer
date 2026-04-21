import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PanelDetailsDialog extends StatelessWidget {
  final BuildContext parentContext;
  final String panelId;

  const PanelDetailsDialog({super.key, required this.parentContext,required this.panelId});

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
                  "Customer Details",
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
            SizedBox(height: s(20)),
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
                    "assets/images/customer/email_icon.png",
                    "Email",
                    "Ro@gmail.com",
                    scale,
                    22,
                    19,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/customer/phone_icon.png",
                    "Phone Number",
                    "98745 63201",
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

            SizedBox(height: s(20)),
            Text(
              "Address",
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                color: ColorPalette.bottomtext,
              ),
            ),
            SizedBox(height: s(16)),
            Container(
              width: s(360), // Outer box width
              height: s(82), // Outer box height
              padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(12)), // Reduced horizontal padding
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF000000).withOpacity(0.10),
                  width: s(1),
                ),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: s(35),),
                child: Center(
                  child: SizedBox(
                    width: s(310), // Increased slightly to ensure "Coimbatore" fits
                    child: Text(
                      "48/5 GP Signal, Gandhipuram, Coimbatore- 642028",
                      softWrap: false, // Prevents automatic wrapping to second line
                      overflow: TextOverflow.visible, // Ensures text is shown even if tight
                      style: GoogleFonts.lato(
                        fontSize: s(13), // Slightly smaller font size to match design scale
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF484848),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: s(24)),

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