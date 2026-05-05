import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController controller =
  PageController();

  int currentIndex = 0;

  late final List<Map<String, String>> pages = [
    {
      "image":
      "assets/images/onboarding/onboarding1.webp",
      "desc":
      "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
    },
    {
      "image":
      "assets/images/onboarding/onboarding2.webp",
      "desc":
      "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
    },
    {
      "image":
      "assets/images/onboarding/onboarding3.webp",
      "desc":
      "Lorem ipsum dolor sit amet,\nadipiscing elit. Fusce quam tortor,",
    },
  ];

  void nextPage() {
    if (currentIndex == pages.length - 1) {
      context.go('/login');
    } else {
      controller.nextPage(
        duration:
        const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final w =
        MediaQuery.of(context).size.width;

    final h =
        MediaQuery.of(context).size.height;

    final scale = w / 440;

    double s(double v) => v * scale;

    final logoWidth = w * 0.659;
    final logoHeight = logoWidth * 0.1067;

    return Scaffold(
      body: Stack(
        children: [

          /// PAGEVIEW
          PageView.builder(
            controller: controller,
            itemCount: pages.length,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            itemBuilder: (context, index) {

              return Stack(
                fit: StackFit.expand,
                children: [

                  /// BACKGROUND IMAGE
                  Image.asset(
                    pages[index]["image"]!,
                    fit: BoxFit.cover,
                  ),

                  /// SAFE CONTENT
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: s(20),
                      ),

                      child: Column(
                        children: [

                          SizedBox(
                            height: s(74),
                          ),

                          /// LOGO
                          Image.asset(
                            "assets/images/splash/logo.png",
                            width: logoWidth,
                            height: logoHeight,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(
                            height: s(30),
                          ),

                          /// DESCRIPTION
                          SizedBox(
                            width: s(293),

                            child: Text(
                              pages[index]["desc"]!,
                              textAlign:
                              TextAlign.center,

                              style:
                              GoogleFonts.poppins(
                                color:
                                ColorPalette.whitetext,
                                fontSize: s(16),
                                fontWeight:
                                FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ),

                          const Spacer(),

                          /// NEXT BUTTON
                          Align(
                            alignment:
                            Alignment.centerRight,

                            child: GestureDetector(
                              onTap: nextPage,

                              child: Container(
                                width: s(50),
                                height: s(50),

                                decoration:
                                BoxDecoration(
                                  color:
                                  ColorPalette.whitetext
                                      .withOpacity(0.2),

                                  shape:
                                  BoxShape.circle,

                                  border: Border.all(
                                    color:
                                    ColorPalette.whitetext
                                        .withOpacity(0.1),
                                  ),
                                ),

                                child: Center(
                                  child: Icon(
                                    Icons
                                        .arrow_forward_ios,
                                    color:
                                    ColorPalette.whitetext,
                                    size: s(22),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: s(18)),

                          /// PAGINATION
                          Row(
                            children: List.generate(
                              pages.length,

                                  (i) =>
                                  AnimatedContainer(
                                    duration:
                                    const Duration(
                                      milliseconds: 300,
                                    ),

                                    margin:
                                    EdgeInsets.only(
                                      right: s(7),
                                    ),

                                    width:
                                    currentIndex == i
                                        ? s(89)
                                        : s(30),

                                    height: s(2.5),

                                    decoration:
                                    BoxDecoration(
                                      color:
                                      currentIndex == i
                                          ? ColorPalette
                                          .whitetext
                                          : ColorPalette
                                          .whitetext
                                          .withOpacity(0.3),

                                      borderRadius:
                                      BorderRadius.circular(
                                        s(2),
                                      ),
                                    ),
                                  ),
                            ),
                          ),

                          SizedBox(height: h * 0.04),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}