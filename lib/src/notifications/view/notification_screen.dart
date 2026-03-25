
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/notifications/widgets/notification_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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

                TopHeaderCard(
                  scale: scale,
                  showNotification: false,
                  onBackTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),

          /// ✅ CONTENT BELOW HEADER
          Positioned.fill(
            top: 140 * scale, // 👈 adjust if needed
            child: SafeArea(
              top: false,
              child: Column(
                children: [

                  /// TITLE
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20 * scale,
                      top: 16 * scale,
                      bottom: 10 * scale,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Notification",
                        style: AppTextStyles.title,
                      ),
                    ),
                  ),

                  /// LIST
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                      children: [
                        SizedBox(height: 20 * scale),

                        NotificationCard(
                          scale: scale,
                          title: "New Ticket Assigned",
                          description: "TKT-005 has been assigned to you.\nLocation: Coimbatore",
                        ),

                        NotificationCard(
                          scale: scale,
                          title: "New Ticket Assigned",
                          description: "TKT-006 has been assigned to you.\nLocation: Coimbatore",
                        ),

                        SizedBox(height: 20 * scale),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
