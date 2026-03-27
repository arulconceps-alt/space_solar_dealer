import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return Center(
      child: Container(
        width: s(400),
        constraints: BoxConstraints(
          maxHeight: s(387),
        ),
        padding: EdgeInsets.symmetric(horizontal: s(20)), // ✅ exact 20
        decoration: BoxDecoration(
          color: Colors.white, // ✅ solid (no transparency issue)
          borderRadius: BorderRadius.circular(s(20)),
          border: Border.all(color: Colors.white, width: s(1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 TOP SPACE
            SizedBox(height: s(34)),

            /// 🔹 ICON
            Container(
              width: s(110),
              height: s(110),
              decoration: const BoxDecoration(
                color: Color(0x4C319F43),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/success/tick_circle_outline.png",
                  width: s(44),
                  height: s(44),
                ),
              ),
            ),

            SizedBox(height: s(26)),

            /// 🔹 TITLE
            Text(
              "Ticket Submitted",
              style: GoogleFonts.poppins(
                color: const Color(0xFF282828),
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
                color: const Color(0xCC484848),
                fontSize: s(16),
                fontWeight: FontWeight.w400,
              ),
            ),



            Padding(
              padding: EdgeInsets.only(bottom: s(38),top: s(30)), // ✅ EXACT Figma bottom spacing
              child: GestureDetector(
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
                    color: const Color(0xFF26A7DF),
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "View Ticket",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                    ),
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