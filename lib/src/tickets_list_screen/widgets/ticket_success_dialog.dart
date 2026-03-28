import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_success_animated_tick.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/tickets_details_dialog.dart';

class TicketSuccessDialog extends StatelessWidget {
  final BuildContext parentContext;

  const TicketSuccessDialog({
    super.key,
    required this.parentContext,
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
      
            // /// 🔹 ICON
            // Container(
            //   width: s(110),
            //   height: s(110),
            //   decoration: const BoxDecoration(
            //     color: Color(0x4C319F43),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Center(
            //     child: Image.asset(
            //       "assets/images/success/tick_circle_outline.png",
            //       width: s(44),
            //       height: s(44),
            //     ),
            //   ),
            // ),
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
              "Your Ticket has been created.\nYour Ticket ID is #SS-00120",
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
                showDialog(
                  context: parentContext,
                  builder: (_) => TicketDetailsDialog(),
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