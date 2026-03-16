import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18), // FIXED
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: SizedBox(
                    width: 217,
                    child: Text(
                      '${HomeMockData.welcomeLine1} ${HomeMockData.welcomeLine2}',
                      style: const TextStyle(
                        color: ColorPalette.primary,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        height: 0.92, // FIXED
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Subtitle
                SizedBox(
                  width: 253,
                  child: Text(
                    HomeMockData.welcomeSubtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16, // FIXED
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      height: 1.38,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                /// Disclaimer
                Text(
                  HomeMockData.welcomeDisclaimer,
                  style: const TextStyle(
                    fontSize: 6,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          /// GB Logo
          FadeInRight(
            child: Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.10),
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'GB',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Erotique Trial', // Branding font
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
