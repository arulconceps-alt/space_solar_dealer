import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: ColorPalette.scaffoldGradient),
          ),

          BlurCircle(left: s(-146), top: s(-191), size: s(383), opacity: 1),
          BlurCircle(left: s(399), top: s(44), size: s(383), opacity: 1),
          BlurCircle(left: s(-241), top: s(580), size: s(383), opacity: .4),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                children: [
                  Center(child: LogoWidget(scale: scale)),
                  SizedBox(height: s(55)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: GoogleFonts.poppins(
                              fontSize: s(32),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: ColorPalette.bottomtext,
                            ),
                          ),
                          SizedBox(height: s(8)),
                          Text(
                            'Enter your Login Information',
                            style: GoogleFonts.lato(
                              fontSize: s(16),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: ColorPalette.textfiledin,
                            ),
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
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forget Password?",
                                style: GoogleFonts.lato(
                                  fontSize: s(14),
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color: ColorPalette.background,
                                ),
                              ),
                            ),
                          ),
                    
                          SizedBox(height: s(30)),
                    
                          /// LOGIN BUTTON
                          PrimaryButton(
                            text: "Login",
                            scale: scale,
                            onTap: () => context.push('/home'),
                          ),
                    
                          SizedBox(height: s(44)),
                    
                          /// DIVIDER
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: s(58),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorPalette.blacktext.withValues(
                                    alpha: .2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: s(10),
                                ),
                                child: Text(
                                  'Or Continue with',
                                  style: GoogleFonts.lato(
                                    fontSize: s(12),
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalette.blacktext,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: s(58),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorPalette.blacktext.withValues(
                                    alpha: .2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    
                          SizedBox(height: s(42)),
                    
                          /// SOCIAL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialButton(
                                scale: scale,
                                child: Padding(
                                 padding:  EdgeInsets.all(s(18)),
                                  child: SvgPicture.asset(
                                    "assets/images/login/google.svg",
                                    height: s(24),
                                    width: s(24),
                                  ),
                                ),
                              ),
                              SizedBox(width: s(40)),
                              SocialButton(
                                scale: scale,
                                child: Padding(
                                  padding:  EdgeInsets.all(s(15)),
                                  child: SvgPicture.asset(
                                    "assets/images/login/apple.svg",
                                    height: s(28),
                                    width: s(24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    
                          SizedBox(height: s(40)),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: s(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account yet? ",
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.bottomtext,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/signup'),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
