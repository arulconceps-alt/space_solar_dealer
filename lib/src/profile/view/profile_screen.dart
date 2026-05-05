import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_state.dart';
import 'package:space_solar_dealer/src/profile/view/widget/logout_button.dart';
import 'package:space_solar_dealer/src/profile/view/widget/profile_info_card.dart';

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
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final w = MediaQuery.of(context).size.width;
          final scale = w / 440;
          double s(double v) => v * scale;

          final profile = state.profile;
          final isProfileActive = profile?.status == "ACTIVE";

          if (state.status == ProfileStatus.loading && profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: s(24)),

                          /// HEADER
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Profile',
                                    style: GoogleFonts.poppins(
                                      fontSize: s(20),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Dealer Information',
                                    style: GoogleFonts.lato(fontSize: s(14)),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              // LogoutButton(scale: scale),
                            ],
                          ),

                          SizedBox(height: s(20)),

                          /// ACTIVE STATUS
                          // ActiveStatusCard(
                          //   scale: scale,
                          //   isActive: isProfileActive,
                          //   onToggle: (val) {
                          //     context.read<ProfileBloc>().add(
                          //       UpdateProfileEvent({
                          //         "status": val ? "ACTIVE" : "INACTIVE"
                          //       }),
                          //     );
                          //   },
                          // ),
                          /// PROFILE CARD
                          ProfileInfoCard(
                            scale: scale,
                            isActive: isProfileActive,
                            profile: profile,
                          ),
                          SizedBox(height: s(16)),
                          InkWell(
                            borderRadius: BorderRadius.circular(s(10)),
                            onTap: () {},
                            child: Container(
                              height: s(50),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: s(26),
                                vertical: s(8),
                              ),
                              decoration: BoxDecoration(
                                color: ColorPalette.whitetext.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(s(10)),
                                border: Border.all(
                                  color: ColorPalette.whitetext,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: s(24),
                                    color: ColorPalette.textfiledin.withValues(
                                      alpha: .80,
                                    ),
                                  ),
                                  SizedBox(width: s(10)),
                                  Text(
                                    "Terms&Condition",
                                    style: GoogleFonts.poppins(
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.textfiledin
                                          .withValues(alpha: .80),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: s(100)),
                          // LogoutButton(scale: scale),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: s(20),
                right: s(20),
                bottom: s(20),
                child: LogoutButton(scale: scale),
              ),
              // if (state.status == ProfileStatus.failure)
              //   Center(child: Text(state.message)),

              // if (state.status == ProfileStatus.loading && profile != null)
              //   Positioned.fill(
              //     child: AbsorbPointer(
              //       child: Container(
              //         color: Colors.black.withOpacity(0.3),
              //         child: const Center(
              //           child: CircularProgressIndicator(
              //               color: ColorPalette.background
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          );
        },
      ),
    );
  }
}
