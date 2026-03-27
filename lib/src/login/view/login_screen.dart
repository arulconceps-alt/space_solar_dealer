import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';
import 'package:space_solar_dealer/src/login/widgets/blur_circle.dart';
import 'package:space_solar_dealer/src/login/widgets/field_label.dart';
import 'package:space_solar_dealer/src/login/widgets/glass_field.dart';
import 'package:space_solar_dealer/src/login/widgets/logo_widget.dart';
import 'package:space_solar_dealer/src/login/widgets/primary_button.dart';
import 'package:space_solar_dealer/src/login/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return Scaffold(
      resizeToAvoidBottomInset: false, // ✅ FIXED
      body: Stack(
        children: [
          /// BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: ColorPalette.scaffoldGradient,
            ),
          ),

          /// BLUR CIRCLES
          BlurCircle(left: s(-146), top: s(-201), size: s(383), opacity: 1),
          BlurCircle(left: s(399), top: s(44), size: s(383), opacity: 1),
          BlurCircle(left: s(-241), top: s(580), size: s(383), opacity: .4),

          SafeArea(
            child: Stack(
              children: [
                /// LOGO
                Positioned(
                  top: s(86),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: LogoWidget(scale: scale),
                  ),
                ),

                /// FORM CONTENT
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ), // ✅ FIXED scroll with keyboard
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: s(86 + 20.5644 + 55)),

                        /// TITLE
                        Text(
                          'Welcome Back!',
                          style: AppTextStyles.headingScaled(scale),
                        ),

                        SizedBox(height: s(4)),

                        /// SUBTITLE
                        Text(
                          'Enter your Login Information',
                          style: AppTextStyles.subheadingScaled(scale),
                        ),

                        SizedBox(height: s(31)),

                        /// EMAIL
                        FieldLabel(text: "Email Address", scale: scale),
                        SizedBox(height: s(9)),

                        SizedBox(
                          height: s(50),
                          child: GlassField(
                            controller: _emailController,
                            hint: "Email Address",
                            scale: scale,
                          ),
                        ),

                        SizedBox(height: s(24)),

                        /// PASSWORD
                        FieldLabel(text: "Password", scale: scale),
                        SizedBox(height: s(9)),

                        SizedBox(
                          height: s(50),
                          child: GlassField(
                            controller: _passwordController,
                            hint: "Password",
                            scale: scale,
                            obscure: _obscurePassword,
                          ),
                        ),

                        SizedBox(height: s(12)),

                        /// FORGOT PASSWORD
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.only(
                                top: s(12),
                                bottom: s(4),
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Forget Password?',
                              style:
                              AppTextStyles.labelTextHeadScaled(scale),
                            ),
                          ),
                        ),

                        SizedBox(height: s(30)),

                        /// LOGIN BUTTON
                        PrimaryButton(
                          text: "Login",
                          scale: scale,
                          onTap: () {
                            context.push('/home');
                          },
                        ),

                        SizedBox(height: s(44)),

                        /// OR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: s(58),
                              height: 1,
                              color: const Color(0x331E1E1E),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: s(10)),
                              child: Text(
                                'Or Continue with',
                                style:
                                AppTextStyles.centerTextScaled(scale),
                              ),
                            ),
                            Container(
                              width: s(58),
                              height: 1,
                              color: const Color(0x331E1E1E),
                            ),
                          ],
                        ),

                        SizedBox(height: s(40)),

                        /// SOCIAL BUTTONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialButton(
                              scale: scale,
                              child: SizedBox(
                                width: scale * 192.7461,
                                height: s(24),
                                child: SvgPicture.asset(
                                  "assets/images/login/google.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            SizedBox(width: s(40)),

                            SocialButton(
                              scale: scale,
                              child: SizedBox(
                                width: scale * 192.7461,
                                height: s(30),
                                child: SvgPicture.asset(
                                  "assets/images/login/apple.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: s(100)), // 👈 extra safe spacing
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔻 FIXED BOTTOM TEXT (WON'T MOVE)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: s(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet? ",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/signup');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF26A7DF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}