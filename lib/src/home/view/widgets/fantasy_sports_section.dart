import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/home/data/home_mock_data.dart';
import 'package:space_solar_dealer/src/home/view/widgets/banner_image_widget.dart';

class FantasySportsSection extends StatefulWidget {
  const FantasySportsSection({super.key});

  static const tabBarHeight = 46.0;

  @override
  State<FantasySportsSection> createState() => _FantasySportsSectionState();
}

class _FantasySportsSectionState extends State<FantasySportsSection> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              HomeMockData.fantasyTitle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: ColorPalette.primary,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              HomeMockData.fantasyTagline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: ColorPalette.textPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 64,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: BannerImageWidget(
                      path: HomeMockData.fantasyBannerLeft,
                      height: 64,
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 150,
                    child: BannerImageWidget(
                      path: HomeMockData.fantasyBannerRight,
                      height: 64,
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 150,
                    child: BannerImageWidget(
                      path: HomeMockData.fantasyBannerThird,
                      height: 64,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          _buildTabWithCard(),
        ],
      ),
    );
  }

  Widget _buildTabWithCard() {
    const overlap = 12.0;
    const tabPageBg = Color(0xFF2C2C2E);
    const tabPageTopPadding = 16.0;
    const tabPageBottomRadius = 12.0;

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: FantasySportsSection.tabBarHeight - overlap),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tabPageBg,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(tabPageBottomRadius),
                  bottomRight: Radius.circular(tabPageBottomRadius),
                ),
              ),
              padding: const EdgeInsets.only(top: tabPageTopPadding),
              child: _tabIndex == 0 ? _MatchCard() : _UpcomingPlaceholder(),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _FantasyTabBar(
            tabIndex: _tabIndex,
            onTabChanged: (index) => setState(() => _tabIndex = index),
          ),
        ),
      ],
    );
  }
}

class _UpcomingPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      alignment: Alignment.center,
      child: Text(
        'No upcoming matches',
        style: TextStyle(
          fontSize: 14,
          color: ColorPalette.textPrimary.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _FantasyTabBar extends StatelessWidget {
  const _FantasyTabBar({required this.tabIndex, required this.onTabChanged});

  final int tabIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    const cornerRadius = 12.0;
    const tabCornerRadius = 10.0;
    const tabBarBg = Color(0xFF2C2C2E);
    const activeTabBg = Color(0xFF48484B);
    const inactiveTabBg = Color(0xFF3B3B3D);
    const dividerColor = Color(0x1AFFFFFF);

    return Container(
      height: FantasySportsSection.tabBarHeight,
      decoration: BoxDecoration(
        color: tabBarBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 6,
                  left: 6,
                  bottom: 6,
                  right: 2,
                ),
                decoration: BoxDecoration(
                  color: tabIndex == 0 ? activeTabBg : inactiveTabBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(tabCornerRadius),
                    topRight: Radius.circular(tabCornerRadius),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  HomeMockData.fantasyTabOngoing,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorPalette.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            margin: const EdgeInsets.symmetric(vertical: 11),
            color: dividerColor,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 6,
                  left: 2,
                  bottom: 6,
                  right: 6,
                ),
                decoration: BoxDecoration(
                  color: tabIndex == 1 ? activeTabBg : inactiveTabBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(tabCornerRadius),
                    topRight: Radius.circular(tabCornerRadius),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  HomeMockData.fantasyTabUpcoming,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorPalette.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF1C1B20);
    const centerGradientColor = Color(0xFF252428);
    const topBannerColor = Color(0xFF3E3E3E);
    const topTabWidth = 150.0;
    const topTabHeight = 36.0;
    const overlapTop = 18.0;
    const overlapBottom = 8.0;
    const bottomSvgWidth = 52.0;
    const bottomSvgHeight = 10.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(top: overlapTop, bottom: overlapBottom),
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.1,
                colors: [centerGradientColor, cardColor],
                stops: const [0.3, 1.0],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        HomeMockData.matchTeamALogo,
                        fit: BoxFit.cover,
                        errorBuilder: (_, Object? e, StackTrace? st) =>
                            const Center(
                              child: Text(
                                'MI',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      HomeMockData.matchTeamAName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: ColorPalette.textPrimary,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        HomeMockData.matchCountdownLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorPalette.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        HomeMockData.matchCountdown,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: ColorPalette.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        HomeMockData.matchTeamBLogo,
                        fit: BoxFit.cover,
                        errorBuilder: (_, Object? e, StackTrace? st) =>
                            const Center(
                              child: Text(
                                'CSK',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      HomeMockData.matchTeamBName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: ColorPalette.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: topTabWidth,
                height: topTabHeight,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      HomeMockData.matchCardTopSvg,
                      fit: BoxFit.fill,
                      width: topTabWidth,
                      height: topTabHeight,
                      colorFilter: const ColorFilter.mode(
                        topBannerColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Center(
                      child: Text(
                        HomeMockData.matchDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: ColorPalette.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: overlapBottom,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                HomeMockData.matchCardBottomSvg,
                width: bottomSvgWidth,
                height: bottomSvgHeight,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  topBannerColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
