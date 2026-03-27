import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String name;

  const CustomerDetailsScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 440;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows background to flow under AppBar
      backgroundColor: Colors.transparent,

      /// 1. STANDARD APPBAR
      appBar: CommonAppBar(
      scale: scale,
      showBack: true,
      onBackTap: () {
        context.pop();
      },
    ),

      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24 * scale),

                      /// TITLE & SUBTITLE
                      Text(
                        'Customer Detail',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF282828),
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Customer Information',
                        style: GoogleFonts.lato(
                          fontSize: 14 * scale,
                          color: const Color(0xCC484848),
                        ),
                      ),

                      SizedBox(height: 30 * scale),

                      /// 2. PROFILE SECTION (IMAGE/INITIAL)
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100 * scale,
                              height: 100 * scale,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : 'B',
                                style: GoogleFonts.poppins(
                                  fontSize: 40 * scale,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF26A7DF),
                                ),
                              ),
                            ),
                            SizedBox(height: 12 * scale),
                            Text(
                              name,
                              style: GoogleFonts.lato(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF282828),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30 * scale),

                      /// 3. INFO FIELDS
                      _buildField("Panel ID", "SS-001 to SS-024", scale),
                      _buildField("Phone Number", "9876543212", scale),
                      _buildField("Email", "${name.toLowerCase()}123@gmail.com", scale),
                      _buildField("Address", "21/22 Raja colony, Ganapathy, Coimbatore", scale, isAddress: true),

                      SizedBox(height: 40 * scale),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Notification Badge UI
  Widget _buildNotificationBadge(double scale) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          "assets/images/home/notification.svg",
          height: 24 * scale,
          width: 24 * scale,
        ),
        Positioned(
          right: -6,
          top: -6,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Text(
              '16',
              style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Reusable Info Field
  Widget _buildField(String title, String value, double scale, {bool isAddress = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF282828),
            ),
          ),
          SizedBox(height: 8 * scale),
          Container(
            width: double.infinity,
            constraints: isAddress ? BoxConstraints(minHeight: 71 * scale) : null,
            padding: EdgeInsets.all(14 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: Colors.white),
            ),
            child: Text(
              value,
              style: GoogleFonts.lato(
                fontSize: 16 * scale,
                color: const Color(0xCC484848),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}