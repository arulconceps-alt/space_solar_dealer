import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String name;

  const CustomerDetailsScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [
          // --- BACKGROUND BLOBS ---
          RegisterBlurCircle(
            left: -146,
            top: -201,
            size: 383,
            color: Colors.white,
            scale: scale,
            blur: 60,
          ),
          RegisterBlurCircle(
            left: 209,
            top: 94,
            size: 383,
            color: Colors.white.withValues(alpha: 0.3),
            scale: scale,
            blur: 40,
          ),
          RegisterBlurCircle(
            left: -153,
            top: 575,
            size: 383,
            color: Colors.white.withValues(alpha: 0.6),
            scale: scale,
            blur: 50,
          ),

          // --- UI CONTENT ---
          SafeArea(
            child: Column(
              children: [
                TopHeaderCard(
                  scale: scale,
                  onBackTap: () => context.pop(),
                  onNotificationTap: () {
                    context.push('/notification_screen');
                  },
                  showNotification: true,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24 * scale),

                        Text(
                          'Customer Detail',
                          style: TextStyle(
                            color: const Color(0xFF282828),
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 22 * scale),

                        /// PROFILE SECTION
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 100 * scale,
                                height: 100 * scale,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  name.isNotEmpty ? name[0].toUpperCase() : 'B',
                                  style: TextStyle(fontSize: 48 * scale),
                                ),
                              ),
                              SizedBox(height: 11 * scale),
                              Text(name),
                            ],
                          ),
                        ),

                        SizedBox(height: 26 * scale),

                        _buildField("Panel ID", "SS-001 to SS-024", scale),
                        _buildField("Phone Number", "9876543212", scale),
                        _buildField("Email", "${name.toLowerCase()}123@gmail.com", scale),
                        _buildAddressField(
                            "21/22 Raja colony, Ganapathy, Coimbatore", scale),

                        SizedBox(height: 40 * scale),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE WIDGETS ---

  Widget _buildField(String title, String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
              fontFamily: "Lato",
              color: const Color(0xFF282828),
            ),
          ),
          SizedBox(height: 8 * scale),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16 * scale,
                fontFamily: "Lato",
                color: const Color(0xCC484848),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField(String address, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
            fontFamily: "Lato",
            color: const Color(0xFF282828),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 71 * scale),
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 12 * scale,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.50),
            borderRadius: BorderRadius.circular(10 * scale),
            border: Border.all(
              width: 1,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          child: Text(
            address,
            style: TextStyle(
              color: const Color(0xCC484848),
              fontSize: 16 * scale,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}