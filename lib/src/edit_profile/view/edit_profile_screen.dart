import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      /// APPBAR
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        showNotification: true,
        onBackTap: () => context.pop(),
      ),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: s(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: s(30)),

                /// PROFILE IMAGE WITH EDIT ICON
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: s(100),
                        height: s(100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/profile/profile.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: s(5),
                        child: buildEditIcon(scale),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: s(50)),

                _buildField("Company Name", "Company name", s),
                SizedBox(height: s(16)),
                _buildField("Your Name", "Your Name", s),
                SizedBox(height: s(16)),
                _buildField("Email", "Email", s),
                SizedBox(height: s(16)),
                _buildField("Phone Number", "Phone number", s),
                SizedBox(height: s(16)),
                _buildField("Address", "Your Address", s),

                SizedBox(height: s(102)),

                SizedBox(
                  height: s(50),
                  width: s(400),
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(s(10)),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: GoogleFonts.poppins(
                        color: ColorPalette.whitetext,
                        fontSize: s(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + s(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String title,
    String hint,
    double Function(double) s,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            color: ColorPalette.bottomtext,
            fontSize: s(16),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: s(14)),
        Container(
          width: double.infinity,
          height: s(50),
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          decoration: BoxDecoration(
            color: ColorPalette.whitetext.withOpacity(0.50),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(
              color: ColorPalette.whitetext,
              width: 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: GoogleFonts.lato(
              color: ColorPalette.textfiledin.withValues(alpha: .80),
              fontSize: s(16),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditIcon(double scale) {
    double s(double v) => v * scale;

    return Container(
      width: s(30),
      height: s(30),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 4,
          )
        ],
      ),
      child: Center(
        child: Image.asset(
          "assets/images/profile/edit_icon.png",
          width: s(14.4),
          height: s(14.4),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}