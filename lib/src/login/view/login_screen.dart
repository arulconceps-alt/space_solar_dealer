import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: ColorPalette.scaffoldGradient,
            ),
          ),

          /// Blur circles
          BlurCircle(
            left: s(-146),
            top: s(-201),
            size: s(383),
            opacity: 1,
          ),

          BlurCircle(
            left: s(399),
            top: s(44),
            size: s(383),
            opacity: 1,
          ),

          BlurCircle(
            left: s(-241),
            top: s(580),
            size: s(383),
            opacity: .4,
          ),

          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: s(86),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: LogoWidget(scale: scale),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: s(86 + 20.5644 + 55)),

                        /// Title
                        Text(
                          'Welcome Back!',
                          style: GoogleFonts.poppins(
                            fontSize: s(32),
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.bottomtext,
                            height: 1.19,
                          ),
                        ),

                        SizedBox(height: s(4)),

                        /// Subtitle
                        Text(
                          'Enter your Login Information',
                          style: GoogleFonts.lato(
                            fontSize: s(16),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textfiledin,
                            height: 1.40,
                          ),
                        ),

                        SizedBox(height: s(31)),

                        /// Email
                        FieldLabel(
                          text: "Email Address",
                          scale: scale,
                        ),

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

                        /// Password
                        FieldLabel(
                          text: "Password",
                          scale: scale,
                        ),

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
                        SizedBox(height:12),
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
                              style: GoogleFonts.lato(
                                fontSize: s(16),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF26A7DF),
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: s(30)),

                        /// Login button
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
                                style: GoogleFonts.lato(
                                  fontSize: s(12),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1E1E1E),
                                ),
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

                        /// Social
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
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

                        SizedBox(height: s(80)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// bottom signup
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