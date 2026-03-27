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


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 PAGE VIEW (BACKGROUND)
            PageView.builder(
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (i) {
                setState(() => currentIndex = i);
              },
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    /// 🔹 BACKGROUND IMAGE
                    Image.asset(
                      pages[index]["image"]!,
                      fit: BoxFit.cover,
                    ),

                    /// 🔹 TOP CONTENT
                    Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                        /// LOGO
                        Image.asset(
                          iconLogo,
                          width: MediaQuery.of(context).size.width * 0.65,
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: 29),

                        /// DESCRIPTION
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            pages[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style:  GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            /// 🔹 BOTTOM CONTROLS (NO Positioned)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🔥 NEXT BUTTON (RIGHT)
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
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// 🔥 DOT INDICATOR (LEFT)
                    Row(
                      children: List.generate(
                        pages.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          width: currentIndex == index ? 80 : 25,
                          height: 3,
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
            ),
          ],
        ),
      ),
    );
  }
}