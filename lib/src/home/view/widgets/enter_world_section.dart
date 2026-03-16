import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';
import 'package:space_solar_dealer/src/home/view/widgets/banner_image_widget.dart';
import 'package:go_router/go_router.dart';

class EnterWorldSection extends StatelessWidget {
  const EnterWorldSection({super.key});

  void _navigateToCategory(BuildContext context, String categoryId) {
    context.push('/$categoryId');
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(
              width: 217,
              child: Text(
                HomeMockData.enterWorldTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorPalette.primary,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                ),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () => _navigateToCategory(context, 'rummy'),
              child: BannerImageWidget(
                path: HomeMockData.enterWorldMainBanner,
                height: 120,
                label: 'Rummy',
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateToCategory(context, 'cricket'),
                    child: BannerImageWidget(
                      path: HomeMockData.enterWorldCricket,
                      height: 120,
                      label: 'CRICKET',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateToCategory(context, 'lottery'),
                    child: BannerImageWidget(
                      path: HomeMockData.enterWorldLottery,
                      height: 120,
                      label: 'LOTTERY',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: () => _navigateToCategory(context, 'horse_racing'),
              child: BannerImageWidget(
                path: HomeMockData.enterWorldHorseRacing,
                height: 120,
                label: 'Horse Racing',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
