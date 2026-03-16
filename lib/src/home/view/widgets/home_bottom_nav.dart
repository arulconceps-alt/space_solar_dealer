import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const _navInactiveColor = Color(0xFFA9A9A9);
  static const _navIcons = [
    'assets/images/home/home.png',
    'assets/images/home/games.png',
    'assets/images/home/leader_board.png',
    'assets/images/home/profile.png',
  ];
  static const _navLabels = ['Home', 'Games', 'Leaderboard', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.background,
        border: Border(
          top: BorderSide(color: ColorPalette.surfaceDark, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => _NavItem(
                index: index,
                isSelected: selectedIndex == index,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? ColorPalette.primary
        : HomeBottomNav._navInactiveColor;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              HomeBottomNav._navIcons[index],
              width: 24,
              height: 24,
              color: color,
              colorBlendMode: BlendMode.srcIn,
              errorBuilder: (_, Object? e, StackTrace? st) =>
                  Icon(Icons.circle_outlined, size: 24, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              HomeBottomNav._navLabels[index],
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
