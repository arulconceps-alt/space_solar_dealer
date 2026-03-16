import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';
import 'package:space_solar_dealer/src/lottery_game/view/lottery_game_screen.dart';

class AbcGameSection extends StatelessWidget {
  final String selectedState;
  final List<GameModel> games;

  const AbcGameSection({
    super.key,
    required this.selectedState,
    required this.games,
  });

  @override
  Widget build(BuildContext context) {
    final filteredGames = selectedState == "All"
        ? games
        : games.where((g) => g.state == selectedState).toList();

    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          "ABC Game",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredGames.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 167 / 160,
          ),
          itemBuilder: (context, index) {
            return GameCard(game: filteredGames[index]);
          },
        ),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final GameModel game;
  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(game.image),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.state,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.30,
                        letterSpacing: -0.12,
                      ),
                    ),
                    const Text(
                      'Win Price',
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                        letterSpacing: -0.12,
                      ),
                    ),
                    Text(
                      game.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.30,
                        letterSpacing: -0.12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(), // Keeps the "Play Now" section at the bottom

          const Text(
            'Next draw starts in :',
            style: TextStyle(
              color: Color(0xFF9F9F9F),
              fontSize: 10,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
              height: 1.30,
              letterSpacing: -0.10,
            ),
          ),
          const SizedBox(height: 4),

          // Timer Row
          Row(
            children: [
              TimeBox(text: game.hours),
              const Text(
                ' : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TimeBox(text: game.minutes),
              const Text(
                ' : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TimeBox(text: game.seconds),
            ],
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LotteryGameScreen(stateName: game.state),
                ),
              );
            },
            child: Container(
              width: 146,
              height: 34,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFF313038),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Play Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.30,
                  letterSpacing: -0.12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeBox extends StatelessWidget {
  final String text;
  const TimeBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 18,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontStyle: FontStyle.italic,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w600,
          height: 1.30,
          letterSpacing: -0.10,
        ),
      ),
    );
  }
}
