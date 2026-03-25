import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/profile/widget/active_status_card.dart';
import 'package:space_solar_dealer/src/profile/widget/logout_button.dart';
import 'package:space_solar_dealer/src/profile/widget/profile_header.dart';
import 'package:space_solar_dealer/src/profile/widget/profile_info_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),

      body: Stack(
        children: [

          /// 🔵 BACKGROUND + HEADER
          Positioned.fill(
            child: Stack(
              children: [
                RegisterBlurCircle(left: -146, top: -201, size: 383, color: Colors.white, scale: scale, blur: 60),
                RegisterBlurCircle(left: 209, top: 94, size: 383, color: Colors.white.withOpacity(0.3), scale: scale, blur: 40),
                RegisterBlurCircle(left: -153, top: 575, size: 383, color: Colors.white.withOpacity(0.6), scale: scale, blur: 50),

                /// 🔥 HEADER (FIXED TOP)
                TopHeaderCard(
                  scale: scale,
                  onBackTap: null,
                  onNotificationTap: () {
                    context.push('/notification_screen');
                  },
                  showNotification: true,
                ),
              ],
            ),
          ),

          /// ✅ CONTENT BELOW HEADER
          Positioned.fill(
            top: 150 * scale, // 👈 adjust if needed
            child: SafeArea(
              top: false, // 🔥 important
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 16 * scale),

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

                    SizedBox(height: 20 * scale),

                    /// ACTIVE CARD
                    ActiveStatusCard(scale: scale),

                    SizedBox(height: 20 * scale),

                    /// PROFILE INFO
                    const ProfileInfoCard(),

                    SizedBox(height: 30 * scale),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
