
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [

          /// 🔵 BACKGROUND + HEADER (same as CustomerList)
          Positioned.fill(
            child: Stack(
              children: [
                RegisterBlurCircle(left: -146, top: -201, size: 383, color: Colors.white, scale: scale, blur: 60),
                RegisterBlurCircle(left: 209, top: 94, size: 383, color: Colors.white.withOpacity(0.3), scale: scale, blur: 40),
                RegisterBlurCircle(left: -153, top: 575, size: 383, color: Colors.white.withOpacity(0.6), scale: scale, blur: 50),

                /// 🔥 HEADER (NOW PERFECT POSITION)
                TopHeaderCard(
                  scale: scale,
                  onBackTap: () =>context.pop(),
                  onNotificationTap: () {
                    context.push('/notification_screen');
                  },
                  showNotification: true,
                ),
              ],
            ),
          ),

          /// ✅ MAIN CONTENT BELOW HEADER
          Positioned.fill(
            top: 150 * scale, // 👈 adjust based on header height
            child: SafeArea(
              top: false, // 🔥 important (avoid extra gap)
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                child: Column(
                  children: [

                    /// PROFILE IMAGE
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50 * scale,
                            backgroundImage: const AssetImage(
                              "assets/images/profile/profile.png",
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(6 * scale),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.edit, size: 16 * scale),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30 * scale),

                    _buildField("Company Name", "Company name", scale),
                    _buildField("Your Name", "Your Name", scale),
                    _buildField("Email", "Email", scale),
                    _buildField("Phone Number", "Phone number", scale),
                    _buildField("Address", "Your Address", scale),

                    SizedBox(height: 100 * scale),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20 * scale),
          child: SizedBox(
            height: 50 * scale,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF26A7DF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Done",
                style: AppTextStyles.buttonScaled(scale),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable Field Widget
  Widget _buildField(String title, String hint, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titleScaled(scale)),

          SizedBox(height: 6 * scale),

          Container(
            height: 50 * scale,
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              hint,
              style: AppTextStyles.descriptionScaled(scale),
            ),
          ),
        ],
      ),
    );
  }
}