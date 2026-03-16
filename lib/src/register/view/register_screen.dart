import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../app/color_palette.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /// TOP SPACE (same as Login & OTP)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                    ),

                    /// ICON
                    SvgPicture.asset(
                      "assets/images/auth/icon_name.svg",
                      width: 110,
                      height: 110,
                      colorFilter: const ColorFilter.mode(
                        ColorPalette.primary,
                        BlendMode.srcIn,
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// TITLE
                    const Text(
                      "You’re all set to Play!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: ColorPalette.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// DESCRIPTION
                    const Text(
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.43,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 48),

                    /// NAME FIELD
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: ColorPalette.textPrimary,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter Your Name",
                        labelStyle: const TextStyle(
                          color: ColorPalette.textSecondary,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: ColorPalette.outline,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: ColorPalette.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// SAVE BUTTON
                    GestureDetector(
                      onTap: () {
                        context.go("/success");
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: ColorPalette.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Save Name",
                          style: TextStyle(
                            fontSize: 16.7,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.textPrimary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}