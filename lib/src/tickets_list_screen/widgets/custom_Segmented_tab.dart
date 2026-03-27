import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: s(400),
      height: s(50),
      padding: EdgeInsets.all(s(5)), // clean padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(25)),
        border: Border.all(
          color: Colors.white,
          width: s(1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ spread evenly
        children: tabs.map((tab) {
          bool isSelected = selectedTab == tab;

          return GestureDetector(
            onTap: () => onTabChanged(tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: s(94),   // ✅ FIXED WIDTH (Figma)
              height: s(36),  // ✅ FIXED HEIGHT (Figma)
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF26A7DF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(s(20)), // ✅ radius
              ),
              child: Text(
                tab,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF282828),
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}