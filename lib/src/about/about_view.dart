import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
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
                  "About KRG",
                  style: GoogleFonts.poppins(
                    fontSize: s(20),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.bottomtext,
                  ),
                ),

                SizedBox(height: s(20)),

                /// CONTENT CARD
                Text(
                  '''For over two decades, KRG has built a strong foundation in manufacturing excellence through KRG Textile Mills Pvt. Ltd., delivering premium yarns and woven fabrics to both domestic and international markets. With a deep focus on quality, precision, operational efficiency, and advanced textile technology, the group established a reputation for reliability and performance.
        
        Driven by a vision to support India’s sustainable future, founders Mr. K. Rajagopal and Mr. Sivaram expanded into renewable energy with the launch of Sunpro Renewable Energy Pvt. Ltd. In just seven years, Sunpro grew into one of Tamil Nadu’s leading solar EPC companies, successfully executing a wide range of commercial and industrial solar projects.
        
        Continuing this journey of innovation, the group introduced Space Solar under KRG Power Solar Ltd., marking its entry into solar manufacturing. With a state-of-the-art 1 GW solar module manufacturing facility in Palladam, featuring India’s first fully automated PV module production line powered by advanced AI technology, Space Solar represents the next step in delivering high-performance, future-ready solar solutions.''',

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
