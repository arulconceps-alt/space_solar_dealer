import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_bloc.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_event.dart';
import 'package:space_solar_dealer/src/profile/bloc/profile_state.dart';
import 'package:space_solar_dealer/src/profile/view/widget/active_status_card.dart';
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

          /// 🔄 LOADING
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ ERROR
          if (state.status == ProfileStatus.failure) {
            return Center(child: Text(state.message));
          }

          final profile = state.profile;
          final isProfileActive = profile?.status == "ACTIVE";

          return Column(
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
                                style: GoogleFonts.lato(
                                  fontSize: s(14),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          LogoutButton(scale: scale),
                        ],
                      ),

                      SizedBox(height: s(20)),

                      /// ACTIVE STATUS
                      ActiveStatusCard(
                        scale: scale,
                        isActive: isProfileActive,
                        onToggle: (val) {
                          context.read<ProfileBloc>().add(
                            UpdateProfileEvent({
                              "status": val ? "ACTIVE" : "INACTIVE"
                            }),
                          );
                        },
                      ),

                      SizedBox(height: s(16)),

                      /// PROFILE CARD
                      ProfileInfoCard(
                        scale: scale,
                        isActive: isProfileActive,
                        profile: profile,
                      ),

                      SizedBox(height: s(100)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}