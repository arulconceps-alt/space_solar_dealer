import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/description_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/dropdown_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/panelId_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_success_dialog.dart'
    show TicketSuccessDialog;
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/upload_field.dart';

class RaiseTicketDialog extends StatelessWidget {
  final BuildContext parentContext;

  const RaiseTicketDialog({super.key, required this.parentContext});

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
        height: s(706),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Raise New Ticket",
                    style: GoogleFonts.poppins(
                      color: ColorPalette.bottomtext,
                      fontSize: s(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/ticket/cross_icon.png",
                      width: s(12.73),
                      height: s(12.73),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(29)),

              PanelIdField(scale: scale),
              SizedBox(height: s(16)),
              DropdownField(
                scale: scale,
                onTap: () {
                  print("Open dropdown");
                },
              ),
              SizedBox(height: s(16)),
              DescriptionField(scale: scale),
              SizedBox(height: s(16)),

              UploadField(
                scale: scale,
                onTap: () {
                  print("Upload clicked");
                },
              ),

              SizedBox(height: s(40)),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    showDialog(
                      context: parentContext,
                      barrierDismissible: false,
                      builder: (_) => TicketSuccessDialog(
                        parentContext: parentContext,
                      ),
                    );
                  });
                },
                child: Container(
                  width: s(362),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26A7DF),
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
