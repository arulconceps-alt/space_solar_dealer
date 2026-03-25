
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/tickets_details_dialog.dart';

class TicketSuccessDialog extends StatelessWidget {
  final BuildContext parentContext;
  const TicketSuccessDialog({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Center(
      child: Container(
        width: 400 * scale,
        padding: EdgeInsets.symmetric(
          horizontal: 20 * scale,
          vertical: 24 * scale,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔵 Top Icon Circle
            Container(
              width: 110 * scale,
              height: 110 * scale,
              decoration: const BoxDecoration(
                color: Color(0x4C319F43),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/success/tick_circle_outline.png", // 👈 add tick icon
                  width: 44 * scale,
                  height: 44 * scale,
                ),
              ),
            ),

            SizedBox(height: 16 * scale),

            /// Title
            Text(
              "Ticket Submitted",
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF282828),
              ),
            ),

            SizedBox(height: 12 * scale),

            /// Description
            Text(
              "Your Ticket has been created.\nYour Ticket ID is #SS-00120",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14 * scale,
                color: const Color(0xCC484848),
                height: 1.4,
              ),
            ),

            SizedBox(height: 24 * scale),

            /// Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: parentContext,
                  builder: (_) => TicketDetailsDialog(

                  ),
                );
              },
              child: Container(
                height: 50 * scale,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF26A7DF),
                  borderRadius: BorderRadius.circular(10 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  "View Ticket",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.06,
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