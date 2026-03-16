import 'dart:async';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';

class IplBannerSection extends StatefulWidget {
  const IplBannerSection({super.key});

  @override
  State<IplBannerSection> createState() => _IplBannerSectionState();
}

class _IplBannerSectionState extends State<IplBannerSection> {
  static const _sliderHeight = 180.0;
  late PageController _controller;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;
      final count = HomeMockData.iplSliderImages.length;
      final current = _controller.page?.round() ?? 0;
      if (current < count) {
        final next = current + 1;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: _sliderHeight,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: HomeMockData.iplSliderImages.length + 1,
            onPageChanged: (index) {
              if (index == HomeMockData.iplSliderImages.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_controller.hasClients) {
                    _controller.jumpToPage(0);
                  }
                });
              }
            },
            itemBuilder: (context, index) {
              final imageIndex = index % HomeMockData.iplSliderImages.length;
              final path = HomeMockData.iplSliderImages[imageIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    errorBuilder: (_, Object? e, StackTrace? st) => Container(
                      color: ColorPalette.surface,
                      child: const Icon(
                        Icons.image_rounded,
                        color: ColorPalette.primary,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
