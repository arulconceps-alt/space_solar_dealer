import 'package:flutter/material.dart';

class FantasySports extends StatelessWidget {
  const FantasySports({super.key});

  static const tabBarHeight = 46.0;
  static const String _base = 'assets/images/home';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Fantasy Sports',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color(0xFFDFC45C),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'Build your team. Play smart. Win real rewards.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // --- 2. HORIZONTAL SCROLLING BANNERS ---
          SizedBox(
            height: 64,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildBannerImage('$_base/home_placeholder_1.jpg'),
                  const SizedBox(width: 12),
                  _buildBannerImage('$_base/home_ipl_logo.png'),
                  const SizedBox(width: 12),
                  _buildBannerImage('$_base/home_placeholder_1.jpg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Banner Images
  Widget _buildBannerImage(String fullPath) {
    return Container(
      width: 150,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          fullPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF24232A),
            child: const Icon(Icons.broken_image, color: Colors.white10),
          ),
        ),
      ),
    );
  }
}
