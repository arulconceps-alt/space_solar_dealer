
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/_register_success_animation_tick.dart';
class RegistrationSuccessScreen extends StatefulWidget {
  final double scale;
  const RegistrationSuccessScreen({super.key,required this.scale});

  @override
  State<RegistrationSuccessScreen> createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState
    extends State<RegistrationSuccessScreen> {
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Container(
      width: s(400),
      height: s(538.56),
      padding: EdgeInsets.symmetric(horizontal: s(20)),
      decoration: BoxDecoration(
        color: ColorPalette.whitetext,
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(color: ColorPalette.whitetext, width: s(1)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: s(34)),
          // Container(
          //   width: s(110),
          //   height: s(110),
          //   decoration: const BoxDecoration(
          //     color: Color(0x4C319F43),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Padding(
          //     padding:  EdgeInsets.all(s(33)),
          //     child: Image.asset(
          //       "assets/images/success/tick_circle_outline.png",
          //       width: s(44),
          //       height: s(44),
          //     ),
          //   ),
          // ),
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

          SizedBox(height: s(40)),

          /// 🔹 PANEL ID
          Text(
            "Panel ID : SS-00120",
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.textfiledin.withValues(alpha: .80),
            ),
          ),

          SizedBox(height: s(41.68)),

          /// 🔹 DESCRIPTION
          Text(
            "Confirmation sent via SMS & Whatsapp to\ncustomer",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.textfiledin.withValues(alpha: .80),
            ),
          ),

          SizedBox(height: s(55)),

          /// 🔹 PRIMARY BUTTON
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // close dialog
              // optional: navigate
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
                "Register Another Customer",
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
                  color:  ColorPalette.textfiledin.withValues(alpha: .20),
                  width: s(1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Back to Home",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color:  ColorPalette.textfiledin,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}