import 'package:flutter/material.dart';

// Model class for the games
class PureLuckGame {
  final String title;
  final String imagePath;
  final String? categoryBanner;

  const PureLuckGame({
    required this.title,
    required this.imagePath,
    this.categoryBanner,
  });
}

class PureLuckSection extends StatelessWidget {
  const PureLuckSection({super.key});

  // --- Asset Configuration ---
  static const String _base = 'assets/images/home';

  // --- Internal Data ---
  static const List<PureLuckGame> _games = [
    PureLuckGame(
      title: 'MORE SLOTS',
      imagePath: '$_base/home_lobby_slots.png',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'E - GAMING',
      imagePath: '$_base/home_lobby_ezg.png',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'MARBLES LOBBY',
      imagePath: '$_base/home_lobby_asg.png',
      categoryBanner: 'MARBLES',
    ),
    PureLuckGame(title: 'PLAY NOW', imagePath: '$_base/home_lobby_marbles.png'),
    PureLuckGame(
      title: 'WINFINITY',
      imagePath: '$_base/home_lobby_win_live.png',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'ASIA GAMING',
      imagePath: '$_base/home_placeholder_2.jpg',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'EZUGI',
      imagePath: '$_base/home_lobby_vivo.png',
      categoryBanner: 'MORE SLOTS',
    ),
    PureLuckGame(
      title: 'VIVO GAMING',
      imagePath: '$_base/home_lobby_asg.png',
      categoryBanner: 'MORE SLOTS',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE6CD7D);
    const taglineColor = Color(0xFFD4D4D4);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Title & Tagline ---
          const Text(
            'Pure Luck - Instant results.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: goldColor,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'No strategy. Just spin and see',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: taglineColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          // --- 4-Column Grid logic ---
          ...List.generate((_games.length / 4).ceil(), (rowIndex) {
            final startIdx = rowIndex * 4;
            final rowItems = _games
                .asMap()
                .entries
                .where((e) => e.key >= startIdx && e.key < startIdx + 4)
                .toList();

            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex < (_games.length / 4).ceil() - 1 ? 12 : 0,
              ),
              child: Row(
                children: rowItems.map((e) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: e.key % 4 == 0 ? 0 : 6,
                        right: e.key % 4 == 3 ? 0 : 6,
                      ),
                      child: _PureLuckCard(
                        game: e.value,
                        gameNumber: e.key + 1,
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
            border: Border.all(color: goldColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: goldColor.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cardRadius - 1.5),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    game.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF24232A),
                      child: const Icon(Icons.casino, color: goldColor),
                    ),
                  ),
                ),
                // Category Banner
                if (game.categoryBanner != null)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A5F),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        game.categoryBanner!,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Bottom Title Gradient
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Text(
                    game.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Game ${gameNumber.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 10, color: Colors.white70),
        ),
      ],
    );
  }
}
