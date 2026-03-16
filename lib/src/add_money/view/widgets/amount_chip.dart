import 'package:flutter/material.dart';

class AmountChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AmountChip({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.17,
        height: 32.84,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(7.30),
          border: isSelected
              ? Border.all(color: const Color(0xFFDFC45C), width: 1)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : const Color(0xFFFEFEFE).withOpacity(0.8),
            fontSize: 12.77,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.13,
          ),
        ),
      ),
    );
  }
}
