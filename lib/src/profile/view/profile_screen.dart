import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/profile/widget/active_status_card.dart';
import 'package:space_solar_dealer/src/profile/widget/logout_button.dart';
import 'package:space_solar_dealer/src/profile/widget/profile_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isActive = true;

  void onToggle(bool value) {
    setState(() {
      isActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s(24)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile',
                            style: GoogleFonts.poppins(
                              fontSize: s(20),
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.bottomtext,
                            ),
                          ),
                          SizedBox(height: s(4)),
                          Text(
                            'Dealer Information',
                            style: GoogleFonts.lato(
                              color: ColorPalette.textfiledin.withValues(
                                alpha: .80,
                              ),
                              fontSize: s(14),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.more_vert,
                            size: s(20),
                            color: ColorPalette.bottomtext,
                          ),
                          SizedBox(height: s(4)),
                          LogoutButton(scale: scale),
                        ],
                      ),
                    ],
                  ),
      
                  SizedBox(height: s(20)),
      
                  /// ACTIVE STATUS CARD
                  ActiveStatusCard(
                    scale: scale,
                    isActive: isActive,
                    onToggle: onToggle,
                  ),
      
                  SizedBox(height: s(16)),
      
                  /// PROFILE INFO CARD
                  ProfileInfoCard(scale: scale, isActive: isActive),
      
                  SizedBox(height: s(100)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
