import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/login/bloc/login_bloc.dart';
import 'package:space_solar_dealer/src/login/view/widgets/blur_circle.dart';
import 'package:space_solar_dealer/src/login/view/widgets/field_label.dart';
import 'package:space_solar_dealer/src/login/view/widgets/glass_field.dart';
import 'package:space_solar_dealer/src/login/view/widgets/logo_widget.dart';
import 'package:space_solar_dealer/src/login/view/widgets/primary_button.dart';
import 'package:space_solar_dealer/src/login/view/widgets/social_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileNumberController = TextEditingController();
  final FocusNode _mobileFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    // 2. Request focus after the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_mobileFocusNode);
    });
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Figma design width is 440
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          // 1. Show the success snackbar
          CustomSnackBar.show(
            context,
            AlertState(
              message: state.message,
              type: AlertType.success,
              timestamp: DateTime.now(),
            ),
          );

          context.go('/otp_verify', extra: _mobileNumberController.text.trim());
        }

        if (state.status == LoginStatus.failure) {
          // Use your custom static method here
          CustomSnackBar.show(
            context,
            AlertState(
              message: state.message,
              type: AlertType.failure,
              timestamp: DateTime.now(),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == LoginStatus.loading;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // Background & Blurs
              Container(decoration: BoxDecoration(gradient: ColorPalette.scaffoldGradient)),
              BlurCircle(left: s(-146), top: s(-191), size: s(383), opacity: 1),
              BlurCircle(left: s(399), top: s(44), size: s(383), opacity: 1),
              BlurCircle(left: s(-241), top: s(580), size: s(383), opacity: .4),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: s(40)),

                      // ✅ LOGO (FIXED TOP)
                      Center(child: LogoWidget(scale: scale)),

                      SizedBox(height: s(40)),

                      // ✅ TEXT
                      Text(
                        'Phone Number',
                        style: GoogleFonts.poppins(
                          fontSize: s(28),
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.bottomtext,
                        ),
                      ),
                      SizedBox(height: s(8)),

                      Text(
                        "We will send you an One Time Password on this mobile number",
                        style: GoogleFonts.lato(
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin,
                        ),
                      ),

                      SizedBox(height: s(18)),

                      // ✅ INPUT FIELD
                      SizedBox(
                        width: double.infinity,
                        height: s(64),
                        child: GlassField(
                          controller: _mobileNumberController,
                          hint: "+91 813526365",
                          focusNode: _mobileFocusNode,
                          scale: scale,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + s(16),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: "Get OTP",
                            scale: scale,
                            onTap: () {
                              final mobileNumber = _mobileNumberController.text.trim();
                              if (mobileNumber.isEmpty || mobileNumber.length < 10) {
                                CustomSnackBar.show(
                                  context,
                                  AlertState(
                                    message: "Please enter a valid 10-digit mobile number",
                                    type: AlertType.failure,
                                    timestamp: DateTime.now(),
                                  ),
                                );
                                return;
                              }
                              context.read<LoginBloc>().add(
                                OtpGenerate(mobileNumber: mobileNumber),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (isLoading)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.black.withOpacity(0.35),
                      child: Center(
                        child: CircularProgressIndicator(color: ColorPalette.background),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}