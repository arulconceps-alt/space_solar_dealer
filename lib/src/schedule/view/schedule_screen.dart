import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/schedule/widget/schedule_blur_circle.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: ColorPalette.scaffoldGradient,
            ),
          ),

          /// circles
          ScheduleBlurCircle(left: s(179), top: s(-134), size: s(383), opacity: .4),
          ScheduleBlurCircle(left: s(-59), top: s(204), size: s(383), opacity: .4),
          ScheduleBlurCircle(left: s(218), top: s(364), size: s(383), opacity: .4),
          ScheduleBlurCircle(left: s(-193), top: s(488), size: s(383), opacity: .4),
          ScheduleBlurCircle(left: s(-217), top: s(879), size: s(383), opacity: .4),
          ScheduleBlurCircle(left: s(177), top: s(756), size: s(383), opacity: .4),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopHeaderCard(
                    scale: scale,
                    notificationCount: "5",
                  onBackTap: null,
                    onNotificationTap: () {
                      context.push('/notification_screen');
                    },
                    showNotification: true,
                  ),
                  SizedBox(height: s(24)),
                  SizedBox(
                    width: s(226),
                    height: s(30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Good morning, Kumar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: s(20),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: s(20)),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget diagnosticItem({
  required String text,
  required String iconPath,
  required String arrowPath,
  required double scale,
}) {
  double s(double v) => v * scale;

  return Container(
    height: s(52),
    margin: EdgeInsets.only(bottom: s(12)),
    padding: EdgeInsets.symmetric(horizontal: s(14)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(s(6)),
      border: Border.all(color: Colors.white.withOpacity(.4), width: 1),
      color: Colors.white.withOpacity(.15),
    ),
    child: Row(
      children: [
        /// LEFT ICON
        SvgPicture.asset(iconPath, width: s(22), height: s(22)),

        SizedBox(width: s(12)),

        /// TEXT
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: 0,
              color: Colors.black87,
            ),
          ),
        ),

        /// ARROW
        SvgPicture.asset(arrowPath, width: s(18), height: s(18)),
      ],
    ),
  );
}