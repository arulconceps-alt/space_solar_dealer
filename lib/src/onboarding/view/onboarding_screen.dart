import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onboarding/onboarding1.png",
      "desc":
      "Lorem ipsum dolor sit amet, adipiscing elit. Fusce quam tortor,",
    },
    {
      "image": "assets/images/onboarding/onboarding2.png",
      "desc":
      "Lorem ipsum dolor sit amet, adipiscing elit. Fusce quam tortor,",
    },
    {
      "image": "assets/images/onboarding/onboarding3.png",
      "desc":
      "Lorem ipsum dolor sit amet, adipiscing elit. Fusce quam tortor,",
    },
  ];

  void nextPage() {
    if (currentIndex == pages.length - 1) {
      context.go('/login');
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconLogo = "assets/images/splash/logo.png";

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final logoWidth = screenWidth * 0.659;
    final logoHeight = logoWidth * 0.1067;

    final spaceLogoText = screenWidth * 0.075;

    final leftPadding = screenWidth * 0.049;
    final rightPadding = screenWidth * 0.051;
    final bottomPadding = screenHeight * 0.055;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            onPageChanged: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  /// background
                  Image.asset(
                    pages[index]["image"]!,
                    fit: BoxFit.cover,
                  ),

                  /// overlay
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),

                  /// logo + text
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 110),

                          Image.asset(
                            iconLogo,
                            width: logoWidth,
                            height: logoHeight,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: spaceLogoText),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              pages[index]["desc"]!,
                              textAlign: TextAlign.center,
                              style:  GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          /// DOTS + BUTTON
          Positioned(
            bottom: bottomPadding,
            left: leftPadding,
            right: rightPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: List.generate(
                      pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        width: currentIndex == index ? 89 : 30,
                        height: 3,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? ColorPalette.button2
                              : ColorPalette.button1,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),

                /// next button
                GestureDetector(
                  onTap: nextPage,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}