import 'package:flutter/material.dart';

class LotteryBannerSection extends StatefulWidget {
  const LotteryBannerSection({super.key});

  @override
  State<LotteryBannerSection> createState() => _LotteryBannerSectionState();
}

class _LotteryBannerSectionState extends State<LotteryBannerSection> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<String> bannerImages = [
    "assets/images/lottery_home/banner1.png",
    "assets/images/lottery_home/banner2.png",
    "assets/images/lottery_home/banner3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 135,
          child: PageView.builder(
            controller: _controller,
            itemCount: bannerImages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF24232A),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(bannerImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? const Color(0xFFE6C35A)
                    : const Color(0xFFD9D9D9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
