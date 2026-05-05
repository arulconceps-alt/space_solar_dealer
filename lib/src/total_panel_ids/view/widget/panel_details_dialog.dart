import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

import '../../../common/models/panel_model.dart';

class PanelDetailsDialog extends StatelessWidget {
  final PanelModel panel;

  const PanelDetailsDialog({
    super.key,
    required this.panel,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Center(
      child: Container(
        width: s(400),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
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

            /// DETAILS BOX
            Container(
              width: s(360),
              padding: EdgeInsets.symmetric(
                vertical: s(20),
                horizontal: s(16),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Column(
                children: [

                  _infoRow(
                    "assets/images/ticket/noun_profile_icon.png",
                    "Customer Name",
                    panel.customerName,
                    scale,
                    24,
                    17,
                  ),

                  SizedBox(height: s(20)),

                  _infoRow(
                    "assets/images/ticket/solar_panel.png",
                    "Panel ID",
                    panel.serialNumber,
                    scale,
                    28,
                    15,
                  ),

                  SizedBox(height: s(20)),

                  _infoRow(
                    "assets/images/customer/email_icon.png",
                    "Order Number",
                    panel.orderNumber,
                    scale,
                    22,
                    19,
                  ),

                  SizedBox(height: s(20)),

                  _infoRow(
                    "assets/images/customer/phone_icon.png",
                    "Phone Number",
                    panel.customerPhone,
                    scale,
                    22,
                    19,
                  ),

                  SizedBox(height: s(20)),

                  _infoRow(
                    "assets/images/ticket/calender_icon.png",
                    "Created Date",
                    panel.soldAt?.toString() ?? "-",
                    scale,
                    24,
                    18,
                  ),
                ],
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
          color: ColorPalette.textfiledin.withOpacity(0.8),
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