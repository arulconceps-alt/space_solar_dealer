import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 440;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      /// 1. APPBAR
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        onBackTap: () {
          context.pop();
        },
      ),

      body: AppBackground(
        child: SafeArea(
          bottom: false, // Prevents gap between body and bottom bar
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30 * scale),

                /// PROFILE IMAGE WITH EDIT ICON
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100 * scale,
                        height: 100 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage("assets/images/profile/profile.png"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: Container(
                          width: 30 * scale,
                          height: 30 * scale,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x28000000),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 16 * scale,
                            color: const Color(0xFF282828),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40 * scale),

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

      /// 2. FIXED BOTTOM BUTTON (Corrected to remove the line)
      bottomNavigationBar: Container(
        // Ensure this color is identical to the bottom of your AppBackground
        color: const Color(0xFFB5E2F4),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20 * scale, 10 * scale, 20 * scale, 20 * scale),
            child: InkWell(
              onTap: () => context.pop(),
              child: Container(
                height: 50 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF26A7DF),
                  borderRadius: BorderRadius.circular(10 * scale),
                  // Ensure no shadow or border is added here
                  boxShadow: const [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Done',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String title, String hint, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              color: const Color(0xFF282828),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8 * scale),
          Container(
            width: double.infinity,
            height: 50 * scale,
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.50),
              borderRadius: BorderRadius.circular(10 * scale),
              border: Border.all(color: Colors.white, width: 1),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              hint,
              style: GoogleFonts.lato(
                color: const Color(0xCC484848),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}