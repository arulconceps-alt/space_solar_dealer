import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/login/widgets/logo_widget.dart';
import 'package:space_solar_dealer/src/signup/widgets/signup_blur_circle.dart';
import 'package:space_solar_dealer/src/signup/widgets/signup_field_label.dart';
import 'package:space_solar_dealer/src/signup/widgets/signup_glass_field.dart';
import 'package:space_solar_dealer/src/signup/widgets/signup_primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();

  bool hide1 = true;
  bool hide2 = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = (w / 440).clamp(0.85, 1.2);
    double s(double v) => v * scale;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: ColorPalette.scaffoldGradient,
            ),
          ),

          SignupBlurCircle(
            left: s(-146),
            top: s(-201),
            size: s(383),
            opacity: 1.0,
          ),
          SignupBlurCircle(
            left: s(399),
            top: s(44),
            size: s(383),
            opacity: 1.0,
          ),
          SignupBlurCircle(
            left: s(-241),
            top: s(580),
            size: s(383),
            opacity: 0.4,
          ),

          /// 🔹 Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                children: [
                  SizedBox(height: s(60)),
                  Center(child: LogoWidget(scale: scale)),


                  SizedBox(height: s(55)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE
                          Text(
                            "Sign Up Account",
                            style: GoogleFonts.poppins(
                              fontSize: s(32),
                              fontWeight: FontWeight.w600,
                              height: 1.19,
                              color: const Color(0xFF282828),
                            ),
                          ),

                          SizedBox(height: s(4)),
                          Text(
                            "Enter your personal details",
                            style: GoogleFonts.lato(
                              fontSize: s(16),
                              color: const Color(0xFF484848),
                            ),
                          ),

                          SizedBox(height: s(31)),

                          /// FULL NAME
                          SignupFieldLabel("Full Name", scale),
                          SizedBox(height: s(9)),
                          SignupGlassField(
                            controller: name,
                            hint: "Full Name",
                            scale: scale,
                          ),

                          SizedBox(height: s(24)),

                          /// EMAIL
                          SignupFieldLabel("Email Address", scale),
                          SizedBox(height: s(9)),
                          SignupGlassField(
                            controller: email,
                            hint: "Email Address",
                            scale: scale,
                          ),

                          SizedBox(height: s(24)),

                          /// PASSWORD
                          SignupFieldLabel("Password*", scale),
                          SizedBox(height: s(9)),
                          SignupGlassField(
                            controller: pass,
                            hint: "Password",
                            scale: scale,
                            obscure: hide1,
                          ),

                          SizedBox(height: s(24)),

                          /// CONFIRM PASSWORD
                          SignupFieldLabel("Confirm Password*", scale),
                          SizedBox(height: s(9)),
                          SignupGlassField(
                            controller: confirm,
                            hint: "Confirm Password",
                            scale: scale,
                            obscure: hide2,
                          ),

                          SizedBox(height: s(40)),

                          /// BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: SignupPrimaryButton(
                              text: "Sign Up",
                              scale: scale,
                              onTap: () {},
                            ),
                          ),

                          SizedBox(height: s(30)),
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
                          "Already have an account?",
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            " Login",
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              color: const Color(0xFF26A7DF),
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
