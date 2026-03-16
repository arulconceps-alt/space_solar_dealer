import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';

class GameCenterSection extends StatelessWidget {
  const GameCenterSection({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE6CD7D);
    const taglineColor = Color(0xFFD4D4D4);
    const gridSpacing = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            HomeMockData.gameCenterTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: goldColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            HomeMockData.gameCenterTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: taglineColor),
          ),
          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: HomeMockData.gameCenterItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: gridSpacing),
                  child: Container(
                    width: 72,
                    height: 84,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.10),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white.withOpacity(0.10),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
