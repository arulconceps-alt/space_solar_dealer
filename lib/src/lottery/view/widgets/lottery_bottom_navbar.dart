import 'package:flutter/material.dart';

class LotteryBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const LotteryBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  static const _labels = ["Home", "Favorites", "Result", "Profile"];
  static const _icons = [
    "assets/images/bottom_icons/navi_home.png",
    "assets/images/bottom_icons/navi_favourites.png",
    "assets/images/bottom_icons/navi_result.png",
    "assets/images/bottom_icons/navi_profile.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1B1A1F),
        border: Border(top: BorderSide(color: Color(0xFF313038), width: 0.5)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_labels.length, (index) {
              final isSelected = currentIndex == index;
              final color = isSelected
                  ? const Color(0xFFDFC45C)
                  : const Color(0xFFE2E2E2);

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTabSelected(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _icons[index],
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "DM Sans",
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
