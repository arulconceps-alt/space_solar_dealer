import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/_register_success_animation_tick.dart';

class RegistrationSuccessScreen extends StatefulWidget {
  final double scale;
  final List<String> newPanels;
  final String customerType; // NEW: only new panels

  const RegistrationSuccessScreen({
    super.key,
    required this.scale,
    required this.newPanels,
    required this.customerType, // NEW parameter
  });

  @override
  State<RegistrationSuccessScreen> createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState extends State<RegistrationSuccessScreen> {
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Container(
      width: s(400),
      padding: EdgeInsets.symmetric(horizontal: s(16)),
      decoration: BoxDecoration(
        color: ColorPalette.whitetext,
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(color: ColorPalette.whitetext, width: s(1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: s(34)),
          RegisterSuccessAnimatedTick(scale: widget.scale),
          SizedBox(height: s(26)),
          Text(
            "Registered!",
            style: GoogleFonts.poppins(
              fontSize: s(18),
              fontWeight: FontWeight.w500,
              height: s(1),
              color: ColorPalette.bottomtext,
            ),
          ),
          SizedBox(height: s(20)),

          // Show ONLY newly added panels
          if (widget.newPanels.isNotEmpty) ...[
            Text(
              widget.newPanels.length == 1
                  ? "New Panel ID Added:"
                  : "New Panel IDs Added:",
              style: GoogleFonts.lato(
                fontSize: s(14),
                fontWeight: FontWeight.w500,
                color: ColorPalette.bottomtext,
              ),
            ),
            SizedBox(height: s(12)),
            ...widget.newPanels.map(
              (panel) => Padding(
                padding: EdgeInsets.symmetric(vertical: s(4)),
                child: Text(
                  panel,
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiledin.withOpacity(0.80),
                  ),
                ),
              ),
            ),
          ] else ...[
            Text(
              "Customer Registered Successfully!",
              style: GoogleFonts.lato(
                fontSize: s(14),
                fontWeight: FontWeight.w500,
                color: ColorPalette.textfiledin.withOpacity(0.80),
              ),
            ),
          ],

          SizedBox(height: s(20)),

          Text(
            "Confirmation sent via SMS & WhatsApp to customer",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.textfiledin.withValues(alpha: .80),
            ),
          ),

          SizedBox(height: s(35)),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
                widget.customerType == "Register Panels"
                    ? "Register Another Panel"
                    : "Register Another Customer",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
            ),
          ),

          SizedBox(height: s(16)),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.goNamed(RouteName.home);
            },
            child: Container(
              width: double.infinity,
              height: s(50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(s(10)),
                border: Border.all(
                  color: ColorPalette.textfiledin.withValues(alpha: .20),
                  width: s(1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Back to Home",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.textfiledin,
                ),
              ),
            ),
          ),
          SizedBox(height: s(16)),
        ],
      ),
    );
  }
}
