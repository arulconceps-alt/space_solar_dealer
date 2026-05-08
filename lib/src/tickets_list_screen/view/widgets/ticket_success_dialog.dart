import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/ticket_success_animated_tick.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/tickets_details_dialog.dart';

class TicketSuccessDialog extends StatelessWidget {
  final TicketModel ticket;
  final BuildContext parentContext;

  const TicketSuccessDialog({
    super.key,
    required this.parentContext,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: s(20)),
      child: Container(
        width: s(400),
        padding: EdgeInsets.only(
          left: s(20),
          right: s(20),
          bottom: s(48),
          top: s(34),
        ),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
          border: Border.all(color: ColorPalette.whitetext, width: s(1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TicketSuccessAnimatedTick(scale: scale),

            SizedBox(height: s(26)),
            Text(
              "Ticket Submitted",
              style: GoogleFonts.poppins(
                color: ColorPalette.bottomtext,
                fontSize: s(18),
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: s(24)),

            /// 🔹 DESCRIPTION
            Text(
              "Your Ticket has been created.\nYour Ticket ID is ${ticket.ticketNumber}",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: ColorPalette.textfiledin.withValues(alpha: .80),
                fontSize: s(16),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: s(30)),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: parentContext,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.85,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      expand: false,
                      builder: (_, controller) {
                        return TicketDetailsDialog(
                          ticket: ticket,
                          scrollController: controller,
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: s(50),
                decoration: BoxDecoration(
                  color: ColorPalette.background,
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "View Ticket",
                  style: GoogleFonts.poppins(
                    color: ColorPalette.whitetext,
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
