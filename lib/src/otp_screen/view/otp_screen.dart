import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Standard import
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/login/view/widgets/blur_circle.dart';
import 'package:space_solar_dealer/src/login/view/widgets/logo_widget.dart';
import 'package:space_solar_dealer/src/login/view/widgets/primary_button.dart';
import 'package:space_solar_dealer/src/otp_screen/bloc/otp_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _onVerify(String otp) {
    if (otp.length == 6) {
      context.read<OtpBloc>().add(
        VerifyOtpSubmitted(
          phone: widget.phoneNumber,
          otp: otp,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Set a base width (e.g., 375 for standard mobile) to avoid extreme scaling
    final scale = screenWidth / 375;
    double s(double v) => v * scale;

    final defaultPinTheme = PinTheme(
      width: s(50), // Adjusted size to fit 6 pins comfortably on smaller screens
      height: s(56),
      textStyle: GoogleFonts.lato(
        fontSize: s(22),
        color: const Color(0xFF4A4A4A),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(s(8)),
        border: Border.all(
          color: Colors.white.withOpacity(0.7),
          width: 1.0,
        ),
      ),
    );

    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.status == OtpStatus.success) {
          context.go('/home');
        } else if (state.status == OtpStatus.resendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "OTP resent successfully")),
          );
        } else if (state.status == OtpStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? "Error"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == OtpStatus.loading;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              // Background
              Container(decoration: BoxDecoration(gradient: ColorPalette.scaffoldGradient)),

              // Blur Elements
              BlurCircle(left: s(-146), top: s(-191), size: s(383), opacity: 1),
              BlurCircle(left: s(399), top: s(44), size: s(383), opacity: 1),
              BlurCircle(left: s(-241), top: s(580), size: s(383), opacity: .4),

              // UI Content
              IgnorePointer(
                ignoring: isLoading, // Disable interaction during loading
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20), vertical: s(16)),
                    child: Column(
                      children: [
                        SizedBox(height: s(40)),
                        Center(child: LogoWidget(scale: scale)),
                        SizedBox(height: s(50)),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'OTP Verification',
                                  style: GoogleFonts.poppins(
                                    fontSize: s(26),
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.bottomtext,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Enter the OTP sent to ${widget.phoneNumber}",
                                  style: GoogleFonts.lato(
                                    fontSize: s(15),
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalette.textfiledin,
                                  ),
                                ),
                                SizedBox(height: s(40)),
                                Center(
                                  child: Pinput(
                                    length: 6,
                                    controller: controller,
                                    focusNode: _otpFocusNode,
                                    keyboardType: TextInputType.number,
                                    defaultPinTheme: defaultPinTheme,
                                    separatorBuilder: (index) => SizedBox(width: s(6)),
                                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                                  //  onCompleted: _onVerify, // Auto-submit when done
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!.copyWith(
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: s(24)),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.lato(
                                      fontSize: s(15),
                                      color: const Color(0xFF4A4A4A),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      const TextSpan(text: "Don't receive OTP? "),
                                      TextSpan(
                                        text: "Resend OTP",
                                        style: GoogleFonts.lato(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (isLoading) return;
                                            context.read<OtpBloc>().add(
                                              ResendOtpRequested(phone: widget.phoneNumber),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: s(40)),
                                ValueListenableBuilder(
                                  valueListenable: controller,
                                  builder: (context, value, child) {
                                    // The button only works if 6 digits are entered AND we aren't currently loading
                                    final bool canClick = value.text.length == 6 && state.status != OtpStatus.loading;

                                    return PrimaryButton(
                                      text: "Verify",
                                      scale: scale,
                                      onTap: canClick ? () => _onVerify(value.text) : null,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Loading Overlay
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(color: ColorPalette.background),
                ),
            ],
          ),
        );
      },
    );
  }
}