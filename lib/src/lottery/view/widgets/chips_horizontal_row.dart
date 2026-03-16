import 'package:flutter/material.dart';

class ChipsHorizontalRow extends StatelessWidget {
  final String selectedState;
  final List<String> chips;
  final Function(String) onSelected;

  const ChipsHorizontalRow({
    super.key,
    required this.selectedState,
    required this.chips,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF1B1A1F),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          bool isSelected = selectedState == chips[index];

          return GestureDetector(
            onTap: () => onSelected(chips[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                      )
                    : null,
                color: isSelected ? null : const Color(0xFF24232A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                chips[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "DM Sans",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
