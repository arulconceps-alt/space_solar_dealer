import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/ticket_timeline_model.dart';

class TicketTimelineWidget extends StatelessWidget {
  final double scale;
  final List<TimelineItemModel> items;

  const TicketTimelineWidget({super.key, required this.items, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

   final sortedItems = [...items]
  ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timeline',
          style: GoogleFonts.poppins(
            fontSize: s(18),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C2C2C),
          ),
        ),
        SizedBox(height: s(18)),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedItems.length,
          itemBuilder: (context, index) {
            final item = sortedItems[index];
            final isLast = index == sortedItems.length - 1;

            final dotColor = item.statusColor ?? const Color(0xFF2DA8E0);

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: s(12),
                        height: s(12),
                        decoration: BoxDecoration(
                          color: ColorPalette.background,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 1,
                            margin: EdgeInsets.symmetric(vertical: s(4)),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(width: s(14)),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: s(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: s(16),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2C2C2C),
                              ),
                              children: [
                                TextSpan(text: item.title),

                                /// FIX: spacing added
                                if (item.statusLabel != null)
                                  TextSpan(text: " "),

                                if (item.statusLabel != null)
                                  TextSpan(
                                    text: item.statusLabel,
                                    style: GoogleFonts.poppins(
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w600,
                                      color:
                                          item.statusColor ??
                                          const Color(0xFF2C2C2C),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          SizedBox(height: s(6)),

                          Text(
                            item.value,
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              height: 1.5,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          if (item.reason != null) ...[
                            SizedBox(height: s(6)),
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: s(14),
                                  color: Colors.grey,
                                ),
                                SizedBox(width: s(6)),
                                Expanded(
                                  child: Text(
                                    "Reason: ${item.reason}",
                                    style: GoogleFonts.lato(
                                      fontSize: s(13),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if (item.fromName != null || item.toName != null) ...[
                            SizedBox(height: s(4)),
                            Text(
                              "From: ${item.fromName ?? '-'} → To: ${item.toName ?? '-'}",
                              style: GoogleFonts.lato(
                                fontSize: s(13),
                                color: Colors.black87,
                              ),
                            ),
                          ],
                          // if (item.changedByName != null) ...[
                          //   SizedBox(height: s(4)),
                          //   Text(
                          //     "By: ${item.changedByName}",
                          //     style: GoogleFonts.lato(
                          //       fontSize: s(13),
                          //       color: Colors.black87,
                          //     ),
                          //   ),
                          // ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
