import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/models/game_model.dart';

class WhatsInGbSection extends StatelessWidget {
  final List<LotteryFeatureModel> features;

  const WhatsInGbSection({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Text(
          "What's in GB",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFDFC45C),
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.38,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: features.map((feature) {
              return _buildFeatureItem(feature.label, feature.imagePath);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String label, String imagePath) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 60,
          decoration: ShapeDecoration(
            color: const Color(0xFF201F25),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.white.withOpacity(0.10)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
          // ClipRRect ensures the image doesn't "leak" outside the rounded corners
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                color: Colors.white24,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
