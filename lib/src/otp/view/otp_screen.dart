import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  bool isCertified = true;
  bool isLoading = false;

  final String iconOtp = "assets/images/auth/icon_otp.svg";

  @override
  void initState() {
    super.initState();
    otpController.text = "123456";
    isCertified = true;
  }

  void _validateOtp() {
    if (otpController.text.length < 6) {
      _showError("Please enter a 6-digit OTP");
    } else if (!isCertified) {
      _showError("Please check the certification box");
    } else {
      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        context.go("/register");
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: ColorPalette.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),

                        /// OTP ICON
                        SvgPicture.asset(
                          iconOtp,
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
                          "Enter your OTP",
                          style: TextStyle(
                            color: ColorPalette.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// DESCRIPTION
                        const Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorPalette.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                          ),
                        ),

                        const SizedBox(height: 48),

                        /// OTP INPUT
                        _buildOtpField(),

                        const SizedBox(height: 16),

                        /// HELP TEXT
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter the 6 digit OTP you received in your phone",
                            style: TextStyle(
                              color: ColorPalette.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// CHECKBOX
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: isCertified,
                                onChanged: (v) =>
                                    setState(() => isCertified = v!),
                                checkColor: ColorPalette.textPrimary,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return ColorPalette.primary;
                                      }
                                      return Colors.transparent;
                                    }),
                                side: const BorderSide(
                                  color: ColorPalette.outline,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Text(
                              "I certify that I am 18 years old",
                              style: TextStyle(
                                color: ColorPalette.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        /// SUBMIT BUTTON
                        _buildSubmitButton(),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// LOADER
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: const Center(
                child: CircularProgressIndicator(color: ColorPalette.primary),
              ),
            ),
        ],
      ),
    );
  }

  /// OTP INPUT FIELD
  Widget _buildOtpField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(primary: ColorPalette.primary),
      ),
      child: TextField(
        controller: otpController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        style: const TextStyle(color: ColorPalette.textPrimary, fontSize: 16),
        decoration: InputDecoration(
          counterText: "",
          labelText: "Enter Your OTP",
          labelStyle: const TextStyle(color: ColorPalette.textPrimary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.outline, width: 1),
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
    );
  }

  /// SUBMIT BUTTON
  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: isLoading ? null : _validateOtp,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: ColorPalette.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Submit",
          style: TextStyle(
            color: ColorPalette.textPrimary,
            fontSize: 16.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
