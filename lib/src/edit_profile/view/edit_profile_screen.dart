import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/profile_model.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  @override
  void initState() {
    super.initState();

    nameController.text = widget.profile.name ?? "";
    emailController.text = widget.profile.email ?? "";
    phoneController.text = widget.profile.phone ?? "";
    addressController.text = widget.profile.addressLine1 ?? "";
    companyController.text =
        widget.profile.dealerProfile?.businessName ?? "No Company"; // ✅ FIXED
  }

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

                _buildField(
                  "Company Name",
                  "Company name",
                  companyController,
                  s,
                ),
                SizedBox(height: s(16)),

                _buildField("Your Name", "Your Name", nameController, s),
                SizedBox(height: s(16)),

                _buildField("Email", "Email", emailController, s),
                SizedBox(height: s(16)),
                AbsorbPointer(
                  absorbing: true,
                  child: _buildField(
                    "Phone Number",
                    "Phone",
                    phoneController,
                    s,
                  ),
                ),
                SizedBox(height: s(16)),

                _buildField("Address", "Your Address", addressController, s),

                SizedBox(height: s(102)),

                SizedBox(
                  height: s(50),
                  width: s(400),
                  child: ElevatedButton(
                    onPressed: () {
                      final body = {
                        "name": nameController.text.trim(),
                        "email": emailController.text.trim(),
                        "addressLine1": addressController.text.trim(),
                        "dealerProfile": {
                          "businessName": companyController.text.trim(),
                        },
                      };

                      context.read<ProfileBloc>().add(UpdateProfileEvent(body));

                      context.pop(); // go back
                    },
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

                SizedBox(height: MediaQuery.of(context).padding.bottom + s(16)),
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
      TextEditingController controller,
      double Function(double) s, {
        bool enabled = true,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: s(14),
            fontWeight: FontWeight.w500,
            color: ColorPalette.bottomtext,
          ),
        ),
        SizedBox(height: s(8)),
        TextField(
          controller: controller,
          enabled: enabled,
          style: GoogleFonts.lato(
            fontSize: s(14),
            color: ColorPalette.bottomtext,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.lato(
              color: ColorPalette.textfiledin.withValues(alpha: 0.7),
            ),
            filled: true,
            fillColor: ColorPalette.whitetext.withOpacity(0.5),
            contentPadding: EdgeInsets.symmetric(
              horizontal: s(16),
              vertical: s(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s(10)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s(10)),
              borderSide: BorderSide(color: Colors.white),
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
        boxShadow: const [BoxShadow(color: Color(0x28000000), blurRadius: 4)],
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