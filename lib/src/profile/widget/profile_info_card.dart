import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/profile/widget/profile_info_row.dart';

class ProfileInfoCard extends StatelessWidget {
  final double scale;
  final bool isActive;

  const ProfileInfoCard({
    super.key,
    required this.scale,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(s(30)),
                child: Image.asset(
                  "assets/images/profile/profile.png",
                  width: s(60),
                  height: s(60),
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: s(12)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name + Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kavin Kumar",
                          style: GoogleFonts.lato(
                            fontSize: s(18),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF282828),
                          ),
                        ),

                        AnimatedContainer(
                          height: s(26),
                          width: s(72),
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF319F43).withValues(alpha: .60)
                                : const Color(0xFFAAAAAA),
                            borderRadius: BorderRadius.circular(s(6)),
                          ),
                          child: Text(
                            isActive ? 'Active' : 'Offline',
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: s(17)),

                    /// INFO ROWS
                    ProfileInfoRow(
                      s: s,
                      iconPath: "assets/images/profile/star.svg",
                      iconSize: 22,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '4.8',
                              style: GoogleFonts.lato(
                                fontSize: s(14),
                                fontWeight: FontWeight.w400,
                                height: s(1),
                                color: ColorPalette.bottomtext,
                              ),
                            ),
                            TextSpan(
                              text: ' (100 reviews)',
                              style: GoogleFonts.lato(
                                fontSize: s(14),
                                fontWeight: FontWeight.w400,
                                height: s(1),
                                color: ColorPalette.textfiledin.withValues(
                                  alpha: .80,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: s(13)),

                    ProfileInfoRow(
                      s: s,
                      iconSize: 18,
                      iconPath: "assets/images/profile/call.svg",
                      text: '+91 98745 63210',
                    ),

                    SizedBox(height: s(13)),

                    ProfileInfoRow(
                      s: s,
                      iconSize: 18,
                      iconPath: "assets/images/profile/mail.svg",
                      text: 'kumar@gmail.com',
                    ),

                    SizedBox(height: s(13)),

                    ProfileInfoRow(
                      s: s,
                      iconSize: 20,
                      iconPath: "assets/images/profile/location.svg",
                      text: '40 Ganapathy , Coimbatore- 642108',
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: s(30)),

          Container(height: s(1), color: Color(0x000000).withOpacity(0.20)),

          SizedBox(height: s(14)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Member Since',
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        height: s(1),
                        color: ColorPalette.textfiledin,
                      ),
                    ),
                    TextSpan(
                      text: ' : Nov 2005',
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        height: s(1),
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: s(30)),
              GestureDetector(
                onTap: () {
                  context.push('/edit_profile_screen');
                },
                child: Container(
                  height: s(37),
                  width: s(146),
                  alignment: Alignment.center, 
                  padding: EdgeInsets.symmetric(
                    horizontal: s(16),
                    vertical: s(10),
                  ),
                  decoration: BoxDecoration(
                    color: ColorPalette.bottomtext,
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  child: Text(
                    "Edit Profile",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: s(14),
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: ColorPalette.whitetext,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
