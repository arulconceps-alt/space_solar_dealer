import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
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
  @override
  Widget build(BuildContext context) {
    // Calculate scale factor based on Figma design width (440)
    final double scale = MediaQuery.of(context).size.width / 440;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24 * scale),

                    /// HEADER + LOGOUT ROW (UNCHANGED)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: ProfileHeader(scale: scale),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.more_vert,
                              size: 20 * scale,
                              color: const Color(0xFF282828),
                            ),
                            SizedBox(height: 4 * scale),
                            LogoutButton(scale: scale),
                          ],
                        ),
                      ],
                    ),


                    SizedBox(height: 25 * scale),

                    /// ACTIVE STATUS CARD
                    ActiveStatusCard(scale: scale),

                    SizedBox(height: 20 * scale),

                    /// PROFILE INFO CARD
                    const ProfileInfoCard(),

                    /// EXTRA BOTTOM SPACING
                    SizedBox(height: 100 * scale),
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