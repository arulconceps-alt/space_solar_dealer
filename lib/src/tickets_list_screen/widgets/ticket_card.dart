import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class TicketCard extends StatelessWidget {
  final String ticketId, customerName, status, issue, panelId, date, sla;
  final Color statusColor;
  final VoidCallback onViewDetails;
  final double scale;

  const TicketCard({
    super.key,
    required this.ticketId,
    required this.customerName,
    required this.status,
    required this.issue,
    required this.panelId,
    required this.date,
    required this.sla,
    required this.statusColor,
    required this.onViewDetails,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: s(400),
      margin: EdgeInsets.only(bottom: s(16)),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.50),
        border: Border.all(width: s(1), color: ColorPalette.whitetext),
        borderRadius: BorderRadius.circular(s(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(s(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Ticket ID + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticketId,
                      style: GoogleFonts.lato(
                        color: ColorPalette.textfiledin,
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    _buildBadge(s),
                  ],
                ),

                SizedBox(height: s(8)),

                /// Customer Name
                Text(
                  customerName,
                  style: GoogleFonts.lato(
                    color: ColorPalette.bottomtext,
                    fontSize: s(18),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: s(8)),

                /// Issue
                Text(
                  issue,
                  style: GoogleFonts.lato(
                    color: ColorPalette.textfiledin,
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: s(27)),

                /// Panel ID + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Panel ID : $panelId',
                      style: GoogleFonts.lato(
                        color: ColorPalette.textfiledin,
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.lato(
                        color: ColorPalette.textfiled,
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: s(6)),
                Divider(
                  height: s(1),
                  thickness: s(1),
                  color: Color(0xFF000000).withOpacity(0.20),
                ),
              ],
            ),
            SizedBox(height: s(14)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SLA : $sla',
                  style: GoogleFonts.lato(
                    color: ColorPalette.textfiledin,
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: s(146),
                  height: s(37),
                  child: GestureDetector(
                    onTap: onViewDetails,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorPalette.background.withOpacity(0.3), // 30% opacity background
                        borderRadius: BorderRadius.circular(s(10)), // radius 10
                      ),
                      child: Text(
                        'View Details',
                        style: GoogleFonts.poppins(
                          color: ColorPalette.background, // text color
                          fontSize: s(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(double Function(double) s) {
    return Container(
      width: s(72), 
      height: s(20), 
      alignment: Alignment.center, 
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.30),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          color: statusColor,
          fontSize: s(10), 
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
