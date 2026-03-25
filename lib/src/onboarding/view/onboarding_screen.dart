import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentIndex = 0;

  late final List<Map<String, String>> pages = [
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
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
                          Image.asset(
                            pages[index]["image"]!,
                            fit: BoxFit.cover,
                          ),

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
                                  const SizedBox(height: 20),
                                  const SizedBox(
                                    width: 293,
                                    child: Text(
                                      "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
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
                  Positioned(
                    bottom: bottomPadding,
                    left: leftPadding,
                    right: rightPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔥 BUTTON (TOP RIGHT)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: nextPage,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// 🔥 DOTS (BOTTOM LEFT)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            pages.length,
                                (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 6),
                              width: currentIndex == index ? 80 : 25,
                              height: 2.5,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        ],
      ),
    ),
    ],
        ),
      ),
    );
  }
}