import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/profile/widget/active_status_card.dart';
import 'package:space_solar_dealer/src/profile/widget/logout_button.dart';
import 'package:space_solar_dealer/src/profile/widget/profile_header.dart';
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
      body: AppBackground(
        child: Column(
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
                        ProfileHeader(scale: scale),

                        ///FIXED ALIGNMENT
                        const Spacer(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.more_vert,
                              size: s(20),
                              color: const Color(0xFF282828),
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
      ),
    );
  }
}
