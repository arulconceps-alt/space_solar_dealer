
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String ticketId, customerName, status, issue, panelId, date, sla;
  final Color statusColor;
  final VoidCallback onViewDetails;
  final double scale;

  const TicketCard({
    super.key,
    required this.ticketId, required this.customerName, required this.status,
    required this.issue, required this.panelId, required this.date,
    required this.sla, required this.statusColor, required this.onViewDetails,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16 * scale),
        decoration: ShapeDecoration(
          color: Colors.white.withValues(alpha: 0.50),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 0.50),),
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticketId, style: TextStyle(color: Color(0xFF484848), fontSize: 14 * scale)),
                    _buildBadge(),
                  ],
                ),
                SizedBox(height: 8 * scale),
                Text(customerName, style: TextStyle(color: Color(0xFF282828), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 12 * scale),
                Text(issue, style: TextStyle(color: Color(0xFF484848), fontSize: 14 * scale)),
                SizedBox(height: 16 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Panel ID : $panelId', style: TextStyle(color: Color(0xFF484848), fontSize: 14 * scale)),
                    Text(date, style: TextStyle(color: Color(0xFF484848), fontSize: 14 * scale)),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black.withValues(alpha: 0.1)),
          Padding(
            padding: EdgeInsets.all(12 * scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SLA : $sla', style: TextStyle(color: Color(0xFF484848), fontSize: 14 * scale)),
                GestureDetector(
                  onTap: onViewDetails,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 8 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A7DF).withValues(alpha: 0.2), // Matches Figma's button style
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(color: const Color(0xFF26A7DF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
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

  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15), // ✅ like figma
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 10 * scale,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}