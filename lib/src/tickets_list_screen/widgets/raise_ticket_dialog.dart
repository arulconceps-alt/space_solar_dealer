
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_success_dialog.dart' show TicketSuccessDialog;

class RaiseTicketDialog extends StatelessWidget {
  final BuildContext parentContext;

  const RaiseTicketDialog({
    super.key,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Material(
      color: Colors.transparent, // 🔥 important for dialog background
      child: Center(
        child: Container(
          width: 400 * scale,
          padding: EdgeInsets.all(20 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20 * scale),
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + CLOSE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Raise New Ticket",
                      style: TextStyle(
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "assets/images/ticket/cross_icon.png",
                        width: 12,
                        height: 12,
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20 * scale),

                /// PANEL ID
                _label("Panel ID*", scale),
                _input("Enter Panel ID", scale),

                SizedBox(height: 16 * scale),

                /// ISSUE TYPE
                _label("Select Issue type*", scale),
                _input("Select issue type", scale, isDropdown: true),

                SizedBox(height: 16 * scale),

                /// DESCRIPTION
                _label("Description*", scale),
                _input("Describe the issue in detail", scale, height: 90),
                SizedBox(height: 20 * scale),/// UPLOAD
                _uploadBox(scale),
                SizedBox(height: 24 * scale),
                /// DONE BUTTON
                GestureDetector(
                  onTap: () {
                    /// 1️⃣ Close current dialog (Raise Ticket)
                    Navigator.pop(context);

                    /// 2️⃣ Open success dialog AFTER closing
                    Future.delayed(const Duration(milliseconds: 200), () {
                      showDialog(
                        context: parentContext,
                        barrierDismissible: false,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: TicketSuccessDialog(parentContext: parentContext,),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: 362,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A7DF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable label
  Widget _label(String text, double scale) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  Widget _uploadBox(double scale) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: const Color(0xFFBDBDBD),
        strokeWidth: 1.5,
        dashPattern: const [6, 4],
        radius: Radius.circular(12 * scale),
      ),
      child: Container(
        width: double.infinity,
        height: 120 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 UPLOAD ICON (FROM ASSETS)
            Image.asset(
              "assets/images/ticket/upload_icon.png", // 👈 your path
              width: 28 * scale,
              height: 28 * scale,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 8 * scale),

            /// 🔹 TEXT
            Text(
              "Click to Upload Invoice",
              style: TextStyle(
                fontSize: 14 * scale,
                color: const Color(0xFF484848),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// 🔹 Reusable input
  Widget _input(String hint, double scale,
      {double height = 50, bool isDropdown = false}) {
    return Container(
      height: height * scale,
      margin: EdgeInsets.only(top: 8 * scale),
      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10 * scale),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: TextStyle(color: Colors.black54),
            ),
            if (isDropdown) const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

}