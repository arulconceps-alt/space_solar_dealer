import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class TermsConditionView extends StatefulWidget {
  const TermsConditionView({super.key});

  @override
  State<TermsConditionView> createState() => _TermsConditionViewState();
}

class _TermsConditionViewState extends State<TermsConditionView> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        showNotification: true,
      ),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: s(20), vertical: s(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  "Terms & Condtion",
                  style: GoogleFonts.poppins(
                    fontSize: s(20),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.bottomtext,
                  ),
                ),

                SizedBox(height: s(20)),

                /// CONTENT
                Text(
                  '''By purchasing and installing solar panel systems from our company, the customer agrees to comply with all applicable terms and conditions. The company ensures that all products supplied meet industry standards and are covered under manufacturer warranty; however, performance may vary based on environmental conditions, usage, and maintenance.

Customers are responsible for providing accurate site details and ensuring safe access for installation and servicing. Any modifications, misuse, unauthorized repairs, or improper handling of the system may void the warranty coverage.

The company shall not be held liable for damages caused by natural disasters, power fluctuations, third-party interference, or circumstances beyond reasonable control. Maintenance and periodic inspections are recommended to ensure optimal system efficiency and long-term performance.

By proceeding with the purchase, the customer acknowledges and accepts all installation guidelines, payment terms, warranty policies, and service conditions provided by the company.''',

                  textAlign: TextAlign.justify,

                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiledin,
                  ),
                ),

                SizedBox(height: s(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
