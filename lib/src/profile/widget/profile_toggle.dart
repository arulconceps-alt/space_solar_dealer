import 'package:flutter/material.dart';

class ProfileToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double Function(double) s;

  const ProfileToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
        width: s(74),
        height: s(36),
        decoration: BoxDecoration(
          color: value
              ? const Color(0xFF26A7DF)
              : const Color(0xFFCBCBCB),
          borderRadius: BorderRadius.circular(s(18)),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOut,
              left: value ? s(42) : s(4),
              top: s(4),

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                width: s(28),
                height: s(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: s(4),
                      offset: Offset(0, s(2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}