import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CustomSegmentedTab extends StatelessWidget {
  final double scale;
  final List<String> tabs;
  final String selectedTab;
  final Function(String) onTabChanged;

  const CustomSegmentedTab({
    super.key,
    required this.scale,
    required this.tabs,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: double.infinity,
      height: s(50),
      padding: EdgeInsets.all(s(5)),
      decoration: BoxDecoration(
        color: ColorPalette.whitetext.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(
          color: ColorPalette.whitetext,
          width: s(1),
        ),
      ),

      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: s(2)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorPalette.background
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(s(16)),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: isSelected
                        ? ColorPalette.whitetext
                        : ColorPalette.bottomtext,
                    fontSize: s(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}