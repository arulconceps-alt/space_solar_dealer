import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';
import 'package:go_router/go_router.dart';

class GameCategoriesSection extends StatelessWidget {
  const GameCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 118,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: HomeMockData.gameCategories.length,
        itemBuilder: (context, index) {
          final item = HomeMockData.gameCategories[index];
          return FadeInLeft(
            delay: Duration(milliseconds: index * 50),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 2. Check the label and navigate
                      if (item.label == 'Lottery') {
                        context.go("/lotteryhome");
                      } else {
                        // Handle other categories if needed
                        debugPrint("${item.label} clicked");
                      }
                    },

                    child: SizedBox(
                      width: 64,
                      height: 80,
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, Object? e, StackTrace? st) =>
                            Container(
                              color: ColorPalette.surface,
                              child: Icon(
                                Icons.casino_rounded,
                                color: ColorPalette.primary,
                                size: 32,
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
