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
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isLast = index == items.length - 1;

            // ✅ dot color — statusColor இருந்தா அது, இல்லன்னா default blue
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
                            color: ColorPalette.textfiledin.withOpacity(0.20),
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
                          // Title (with In Progress highlight)
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: s(16),
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.bottomtext,
                              ),
                              children: [
                                TextSpan(text: item.title),
                                if (item.statusLabel != null)
                                  TextSpan(
                                    text: item.statusLabel,
                                    style: GoogleFonts.poppins(
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w600,
                                      color:
                                          item.statusColor ??
                                          ColorPalette.bottomtext,
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
                              color: ColorPalette.textfiledin.withOpacity(0.80),
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          if (item.reason != null) ...[
                            SizedBox(height: s(6)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: s(14),
                                  color: Colors.grey.shade500,
                                ),
                                SizedBox(width: s(6)),
                                Expanded(
                                  child: Text(
                                    "Reason: ${item.reason!}",
                                    style: GoogleFonts.lato(
                                      fontSize: s(13),
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (item.changedByName != null) ...[
                            SizedBox(height: s(4)),
                            Row(
                              children: [
                                Text(
                                  "Technician: ",
                                  style: GoogleFonts.lato(
                                    fontSize: s(13),
                                    color: ColorPalette.bottomtext,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: s(6)),
                                Text(
                                  item.changedByName!,
                                  style: GoogleFonts.lato(
                                    fontSize: s(13),
                                    color: ColorPalette.textfiledin.withOpacity(0.80),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
