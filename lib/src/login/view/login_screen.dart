import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/otp/view/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isCertified = true;

  final TextEditingController phoneController = TextEditingController();
  final String iconPhone = "assets/images/auth/icon_phone.svg";

  @override
  void initState() {
    super.initState();
    phoneController.text = "1234567890"; // testing number
    isCertified = true;
  }

  void _validateAndRegister() async {
    String pattern = r'^(?:[+0]91)?[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    String value = phoneController.text.trim();

    if (value.isEmpty) {
      _showError("Please enter your mobile number");
    } else if (!regExp.hasMatch(value.replaceAll(' ', ''))) {
      _showError("Please enter a valid 10-digit number");
    } else if (!isCertified) {
      _showError("You must certify that you are 18+ years old");
    } else {
      setState(() => isLoading = true);

      await Future.delayed(const Duration(seconds: 1));

      setState(() => isLoading = false);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtpScreen()),
      );
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

                        /// Phone Icon
                        SvgPicture.asset(
                          iconPhone,
                          width: 110,
                          height: 110,
                          colorFilter: const ColorFilter.mode(
                            ColorPalette.primary,
                            BlendMode.srcIn,
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// Title
                        const Text(
                          "Just Verify & Play",
                          style: TextStyle(
                            color: ColorPalette.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Description
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

                        /// Mobile Input
                        _buildRefinedTextField(),

                        const SizedBox(height: 16),

                        /// OTP text
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "You will receive an OTP for Verification",
                            style: TextStyle(
                              color: ColorPalette.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// Checkbox
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

                        /// Register Button
                        _buildGradientButton(),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Loader Overlay
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

  /// Input Field
  Widget _buildRefinedTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(primary: ColorPalette.primary),
      ),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: ColorPalette.textPrimary, fontSize: 16),
        decoration: InputDecoration(
          labelText: "Mobile Number",
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

  /// Gradient Button
  Widget _buildGradientButton() {
    return GestureDetector(
      onTap: isLoading ? null : _validateAndRegister,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: ColorPalette.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Register",
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
