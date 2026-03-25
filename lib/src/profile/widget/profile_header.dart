
import 'package:flutter/material.dart';

import 'logout_button.dart';

class ProfileHeader extends StatelessWidget {
  final double scale;

  const ProfileHeader({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile",
          style: TextStyle(
            fontSize: 20 * scale,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF282828),
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          "Dealer Information",
          style: TextStyle(
            fontSize: 14 * scale,
            color: const Color(0xCC484848),
          ),
        ),
      ],
    );
  }
}