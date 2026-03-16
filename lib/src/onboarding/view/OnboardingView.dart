import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/login/view/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  static const int _pageCount = 3;
  static const String _title = 'Play Smart.\nWin Real Money.';
  static const String _description =
      'Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.';

  static const List<String> _collageAssets = [
    'assets/images/onboarding/onboarding_1.jpg',
    'assets/images/onboarding/onboarding_2.jpg',
    'assets/images/onboarding/onboarding_3.jpg',
    'assets/images/onboarding/onboarding_4.jpg',
    'assets/images/onboarding/onboarding_5.jpg',
    'assets/images/onboarding/onboarding_6.jpg',
    'assets/images/onboarding/onboarding_7.jpg',
    'assets/images/onboarding/onboarding_8.jpg',
    'assets/images/onboarding/onboarding_9.jpg',
  ];

  static const String _heroHorseRacing =
      'assets/images/onboarding/onboarding_10.png';
  static const String _heroAthlete =
      'assets/images/onboarding/onboarding_11.png';
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust speed here
    )..repeat(reverse: true); // Moves back and forth
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pageCount,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _OnboardingPageContent(
                  pageIndex: index,
                  animation: _animationController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPageIndicator(),
                  const SizedBox(height: 24),
                  _buildNextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        _pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: _currentPage == index ? 24 : 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: _currentPage == index ? Colors.white : Colors.transparent,
            border: Border.all(
              color: _currentPage == index ? Colors.white : Colors.white54,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.58),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (_currentPage < _pageCount - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.58),
            ),
          ),
          child: const Text(
            "Next",
            style: TextStyle(
              color: Colors.white, // ✅ FIXED
              fontSize: 16.77,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final int pageIndex;
  final Animation<double> animation;

  const _OnboardingPageContent({
    required this.pageIndex,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: pageIndex == 0
              ? _buildCollage(context, animation)
              : _buildHeroImage(
                  pageIndex == 1
                      ? _OnboardingViewState._heroHorseRacing
                      : _OnboardingViewState._heroAthlete,
                ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _OnboardingViewState._title,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _OnboardingViewState._description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: ColorPalette.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollage(BuildContext context, Animation<double> animation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        // Calculate image width based on screen size (3 images visible-ish)
        final double imageWidth = screenWidth * 0.4;
        final double rowHeight = constraints.maxHeight / 3;

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Column(
              children: [
                // ROW 1: Moves Left to Right
                _responsiveRow(
                  [0, 1, 2],
                  animation.value * 40,
                  imageWidth,
                  rowHeight,
                ),

                const SizedBox(height: 10),

                // ROW 2: Moves Right to Left
                _responsiveRow(
                  [3, 4, 5],
                  -animation.value * 40,
                  imageWidth,
                  rowHeight,
                ),

                const SizedBox(height: 10),

                // ROW 3: Moves Left to Right
                _responsiveRow(
                  [6, 7, 8],
                  animation.value * 40,
                  imageWidth,
                  rowHeight,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _responsiveRow(
    List<int> indices,
    double offset,
    double imgWidth,
    double rowHeight,
  ) {
    return Expanded(
      child: Transform.translate(
        // We use a percentage-based offset so it looks the same on small and big screens
        offset: Offset(offset - 20, 0),
        child: OverflowBox(
          // Allow the row to be much wider than the screen so it doesn't "collapse"
          maxWidth: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: indices.map((i) {
              return Container(
                width: imgWidth,
                height: rowHeight,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    _OnboardingViewState._collageAssets[i],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String path) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          path,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter, // FIX
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, ColorPalette.background],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
