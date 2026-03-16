import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/default_top_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class KycVerification extends StatefulWidget {
  const KycVerification({super.key});

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  final String uploadIcon = "assets/images/kyc/upload_icon.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: DefaultTopNavigationBar(
        title: 'KYC Verification',
        onBackTap: () => context.pop(),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              // REMOVE width: 360, replace with double.infinity
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF1C1B20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center everything
                children: [
                  const SizedBox(height: 80),

                  /// Title - Now uses more horizontal space
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Verify your Documents to join Cash Contests',
                      textAlign:
                          TextAlign.center, // Centered to match the design flow
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize:
                            16, // Increased slightly for better visibility
                        fontWeight: FontWeight.w600,
                        height: 1.43,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'This helps us to ensure you’re\nfrom a restricted state',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.60),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// Upload Card
                  Container(
                    width: 300, // Made slightly larger for bigger screens
                    height: 240,
                    decoration: BoxDecoration(
                      color: const Color(0xFF24232A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            uploadIcon,
                            width: 100, // Increased icon size
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Click to upload your documents',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// space between upload and button (Figma)
                  const SizedBox(height: 50),

                  /// Submit Button
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      height: 56, // Slightly taller button for better UX
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the success page using the name defined in your GoRoute
                          context.pushNamed(RouteName.kycFileUpdateSuccess);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
