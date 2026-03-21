import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      height: 50 * scale,
      padding: EdgeInsets.all(5 * scale), // Padding for the selection pill
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(25 * scale),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF26A7DF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20 * scale),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF282828),
                    fontSize: 14 * scale,
                    fontFamily: 'Lato',
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