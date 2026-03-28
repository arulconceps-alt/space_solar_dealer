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
      "desc": "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
    },
    {
      "image": "assets/images/onboarding/onboarding2.png",
      "desc": "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
    },
    {
      "image": "assets/images/onboarding/onboarding3.png",
      "desc": "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
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
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    final iconLogo = "assets/images/splash/logo.png";

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final logoWidth = screenWidth * 0.659;
    final logoHeight = logoWidth * 0.1067;

    final leftPadding = screenWidth * 0.049;
    final rightPadding = screenWidth * 0.051;
    final bottomPadding = screenHeight * 0.055;

    return SafeArea(
      // top: false,
      // bottom: false,
      child: Scaffold(
        body: Column(
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
                                  SizedBox(height: s(74.29)),
                                  Image.asset(
                                    iconLogo,
                                    width: logoWidth,
                                    height: logoHeight,
                                    fit: BoxFit.contain,
                                  ),
      
                                  SizedBox(height: s(29.3)),
      
                                  SizedBox(
                                    width: s(293),
                                    child: Text(
                                      pages[index]["desc"]!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: ColorPalette.whitetext,
                                        fontSize: s(16),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: nextPage,
                              child: Container(
                                width: s(50),
                                height: s(50),
                                decoration: BoxDecoration(
                                  color: ColorPalette.whitetext.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorPalette.whitetext.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child:  Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorPalette.whitetext,
                                    size: s(26),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
      
                        SizedBox(height: s(8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.only(right: s(7)),
                              width: currentIndex == index ? s(89) : s(30),
                              height: s(2.5),
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? ColorPalette.whitetext
                                    : ColorPalette.whitetext.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(s(2)),
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