import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';

class PureLuckSection extends StatelessWidget {
  const PureLuckSection({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE6CD7D);
    const taglineColor = Color(0xFFD4D4D4);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            HomeMockData.pureLuckTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: goldColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            HomeMockData.pureLuckTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: taglineColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          ...List.generate((HomeMockData.pureLuckGames.length / 4).ceil(), (
            rowIndex,
          ) {
            final startIdx = rowIndex * 4;
            final items = HomeMockData.pureLuckGames
                .asMap()
                .entries
                .where((e) => e.key >= startIdx && e.key < startIdx + 4)
                .toList();
            return Padding(
              padding: EdgeInsets.only(
                bottom:
                    rowIndex <
                        (HomeMockData.pureLuckGames.length / 4).ceil() - 1
                    ? 12
                    : 0,
              ),
              child: Row(
                children: items.map((e) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: e.key % 4 == 0 ? 0 : 6,
                        right: e.key % 4 == 3 ? 0 : 6,
                      ),
                      child: RepaintBoundary(
                        child: _PureLuckCard(
                          game: e.value,
                          gameNumber: e.key + 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PureLuckCard extends StatelessWidget {
  const _PureLuckCard({required this.game, required this.gameNumber});

  final PureLuckGame game;
  final int gameNumber;

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE6CD7D);
    const cardRadius = 12.0;
    const borderWidth = 1.5;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(cardRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardRadius),
                border: Border.all(color: goldColor, width: borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: goldColor.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius - 0.5),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        game.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, Object? e, StackTrace? st) =>
                            Container(
                              color: ColorPalette.surfaceDark,
                              child: const Icon(
                                Icons.casino_rounded,
                                color: goldColor,
                                size: 32,
                              ),
                            ),
                      ),
                    ),
                    if (game.categoryBanner != null)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            game.categoryBanner!,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.75),
                          ],
                        ),
                      ),
                      child: Text(
                        game.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Game ${gameNumber.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
