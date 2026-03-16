import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';

class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE6CD7D);
    const promoBgColor = Color(0xFF303030);
    const promoRadius = 14.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: promoBgColor,
          borderRadius: BorderRadius.circular(promoRadius),
        ),
        child: Text(
          HomeMockData.promoTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: goldColor,
          ),
        ),
      ),
    );
  }
}
