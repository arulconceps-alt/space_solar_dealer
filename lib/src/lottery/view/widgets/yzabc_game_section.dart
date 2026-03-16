import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';

class YzabcGameSection extends StatelessWidget {
  final List<GameModel> games;

  const YzabcGameSection({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Center(
          child: Text(
            'YZABC Game',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFDFC45C),
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 9,
            mainAxisSpacing: 10,
            childAspectRatio: 167 / 160,
          ),
          itemBuilder: (context, index) {
            final game = games[index];
            return GameCard(
              title: game.state,
              price: game.price,
              imagePath: game.image,
            );
          },
        ),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;

  const GameCard({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Win Price',
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Next draw starts in :',
            style: TextStyle(
              color: Color(0xFF9F9F9F),
              fontSize: 10,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildTimeUnit('01h'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Text(':', style: TextStyle(color: Colors.white)),
              ),
              _buildTimeUnit('01m'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Text(':', style: TextStyle(color: Colors.white)),
              ),
              _buildTimeUnit('30s'),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF313038),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Play Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String time) {
    return Container(
      width: 42,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontStyle: FontStyle.italic,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
