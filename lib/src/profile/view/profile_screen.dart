import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:space_solar_dealer/src/login/repo/login_repositary.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = "${info.version}+${info.buildNumber}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFFD7EEF8),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final profile = state.profile;

            if (state.status == ProfileStatus.loading &&
                state.profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(18)),
              child: Column(
                children: [
                  SizedBox(height: s(10)),

                  /// TOP HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: GoogleFonts.poppins(
                          fontSize: s(20),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2E2E2E),
                        ),
                      ),

                      /// EDIT BUTTON
                      GestureDetector(
                        onTap: () async {
                          await context.push(
                            '/edit_profile_screen',
                            extra: profile,
                          );

                          context.read<ProfileBloc>().add(LoadProfileEvent());
                        },
                        child: Container(
                          height: s(40),
                          width: s(40),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: s(19),
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: s(16)),

                  /// PROFILE IMAGE
                  Center(
                    child: Container(
                      height: s(82),
                      width: s(82),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.5),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/profile/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: s(14)),

                  /// NAME
                  Text(
                    profile?.name ?? "No Name",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: s(18),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2E2E2E),
                    ),
                  ),

                  SizedBox(height: s(4)),

                  /// SUBTITLE
                  Text(
                    profile?.roleType ?? "",
                    style: GoogleFonts.lato(
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF00A34C),
                    ),
                  ),

                  SizedBox(height: s(28)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dealer Information",
                      style: GoogleFonts.lato(
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                  ),

                  SizedBox(height: s(14)),

                  /// INFO CARD
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.45),
                      borderRadius: BorderRadius.circular(s(18)),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          s,
                          "Company Name",
                          profile?.dealerProfile?.businessName ??
                              "Kovai Solars",
                        ),

                        _divider(s),

                        _infoRow(
                          s,
                          "Phone Number",
                          profile?.phone ?? "9874563215",
                        ),

                        _divider(s),

                        _infoRow(
                          s,
                          "Email",
                          profile?.email ?? "example@gmail.com",
                        ),

                        _divider(s),

                        _infoRow(
                          s,
                          "GST Number",
                          //profile?.dealerProfile?.gstNumber ??
                          "24AAGM0289C1ZP",
                        ),

                        _divider(s),

                        _infoRow(
                          s,
                          "Location",
                          "${profile?.addressLine1 ?? ''}, ${profile?.district?.name ?? ''}, ${profile?.state?.name ?? ''}",
                          isMultiline: true,
                        ),

                        _divider(s),

                        _infoRow(
                          s,
                          "Member Since",
                          profile?.createdAt != null
                              ? profile!.createdAt!.substring(0, 10)
                              : "12 Nov 2025",
                        ),

                        _divider(s),

                        _infoRow(s, "Rating", "4.8 (100 reviews)"),
                      ],
                    ),
                  ),

                  SizedBox(height: s(18)),

                  /// MENU CARD
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.45),
                      borderRadius: BorderRadius.circular(s(18)),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        _menuTile(
                          s: s,
                          title: "About KRG",
                          imagePath: "assets/images/profile/Group.png",
                          imageWidth: 22,
                          imageHeight: 20,
                          onTap: () {
                            context.push('/about');
                          },
                        ),

                        _divider(s),

                        _menuTile(
                          s: s,
                          title: "Settlement",
                          imagePath: "assets/images/profile/settle.png",
                          imageWidth: 22,
                          imageHeight: 22,
                          onTap: () {},
                        ),

                        _divider(s),

                        _menuTile(
                          s: s,
                          title: "Terms & Condition",
                          imagePath: "assets/images/profile/terms.png",
                          imageWidth: 24,
                          imageHeight: 24,
                          onTap: () {
                            context.push('/termscondition');
                          },
                        ),

                        _divider(s),

                        _menuTile(
                          s: s,
                          title: "Privacy Policy",
                          imagePath: "assets/images/profile/privacy.png",
                          imageWidth: 22,
                          imageHeight: 22,
                          onTap: () {
                            context.push('/privacy');
                          },
                        ),

                        _divider(s),

                        _menuTile(
                          s: s,
                          title: "Logout",
                          imagePath: "assets/images/profile/logout.png",
                          imageWidth: 22,
                          imageHeight: 22,
                          onTap: () {
                            _showLogoutDialog(context, s);
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: s(50)),

                  Text(
                    "Version $appVersion",
                    style: GoogleFonts.lato(
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.textfiledin.withOpacity(0.80),
                    ),
                  ),

                  SizedBox(height: s(20)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(
    double Function(double) s,
    String title,
    String value, {
    bool isMultiline = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(18)),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: s(120),
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w500,
                color: ColorPalette.bottomtext,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(double Function(double) s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(14)),
      child: Divider(height: 1, thickness: 1, color: Colors.white),
    );
  }

  Widget _menuTile({
    required double Function(double) s,
    required String title,
    IconData? icon,
    String? imagePath,
    double? imageWidth,
    double? imageHeight,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(s(14)),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(18)),
        child: Row(
          children: [
            /// IMAGE / ICON
            if (imagePath != null)
              Image.asset(
                imagePath,
                width: s(imageWidth ?? 22),
                height: s(imageHeight ?? 22),
                fit: BoxFit.contain,
                color: const Color(0xFF828C8F),
              )
            else
              Icon(icon, size: s(22), color: Colors.black45),

            SizedBox(width: s(16)),

            /// TITLE
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF484848),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, double Function(double) s) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(s(16)),
          ),
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Are you sure you want logout?",
            style: GoogleFonts.lato(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.bottomtext,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                try {
                  final loginRepository = context.read<LoginRepository>();

                  await loginRepository.logout();

                  if (context.mounted) {
                    context.go('/login');
                  }
                } catch (e) {
                  debugPrint("Logout Error => $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
