import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      margin: EdgeInsets.only(bottom: s(16),),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: s(1),
            color: Colors.white.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(s(20)), // ✅ scaled
        ),
        shadows: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: s(4), // ✅ scaled
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 TOP CONTENT
          Padding(
            padding: EdgeInsets.all(s(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Ticket ID + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticketId,
                      style: GoogleFonts.lato(
                        color: const Color(0xCC484848),
                        fontSize: s(14), // ✅ scaled
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
                    color: const Color(0xFF282828),
                    fontSize: s(18), // ✅ scaled
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: s(12)),

                /// Issue
                Text(
                  issue,
                  style: GoogleFonts.lato(
                    color: const Color(0xFF484848),
                    fontSize: s(14), // ✅ scaled
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
                        color: const Color(0xFF484848),
                        fontSize: s(14), // ✅ scaled
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.lato(
                        color: const Color(0xFF484848),
                        fontSize: s(14), // ✅ scaled
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6,),
                Divider(
                  height: s(1),
                  thickness: s(1),
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),

          ),



          /// 🔹 BOTTOM SECTION
          Padding(
            padding: EdgeInsets.only(left: s(24),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// SLA
                Text(
                  'SLA : $sla',
                  style: TextStyle(
                    color: const Color(0xFF484848),
                    fontSize: s(14),
                  ),
                ),

                /// VIEW DETAILS BUTTON
                GestureDetector(
                  onTap: onViewDetails,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s(20),
                      vertical: s(8),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A7DF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(s(10)),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: const Color(0xFF26A7DF),
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 STATUS BADGE
  Widget _buildBadge(double Function(double) s) {
    return Container(
      width: s(72),   // ✅ fixed width
      height: s(20),  // ✅ fixed height
      alignment: Alignment.center, // ✅ center text
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(s(10)), // ✅ correct radius
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          color: const Color(0xFF26A7DF),
          fontSize: s(10), // ✅ scaled
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}