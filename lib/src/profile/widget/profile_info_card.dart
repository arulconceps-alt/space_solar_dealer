
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 440;

    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 Top Row (Image + Name + Active)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/profile/profile.png",
                  width: 60 * scale,
                  height: 60 * scale,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12 * scale),
              /// Name + details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name + Active
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kavin Kumar",
                          style: TextStyle(
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF282828),
                          ),
                        ),

                        /// Active badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12 * scale, vertical: 4 * scale),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2EAD4B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Active",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8 * scale),

                    /// ⭐ Rating
                    _infoRow(Icons.star, "4.8 (100 reviews)", scale),

                    /// 📞 Phone
                    _infoRow(Icons.phone, "+91 98745 63210", scale),

                    /// ✉ Email
                    _infoRow(Icons.email, "kumar@gmail.com", scale),

                    /// 📍 Address
                    _infoRow(Icons.location_on,
                        "40 Ganapathy , Coimbatore- 642108", scale),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16 * scale),

          /// Divider (ONLY HERE ✅)
          Container(
            height: 1,
            color: Colors.black.withOpacity(0.2),
          ),

          SizedBox(height: 12 * scale),

          /// Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Member Since : Nov 2025",
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: const Color(0xCC484848),
                ),
              ),

              InkWell(
                onTap: () {
                  context.push('/edit_profile_screen'); // 👈 your route
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 8 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF282828),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable row (Perfect alignment)
  Widget _infoRow(IconData icon, String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Row(
        children: [
          Icon(icon, size: 16 * scale, color: const Color(0xFF484848)),
          SizedBox(width: 8 * scale),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14 * scale,
                color: const Color(0xCC484848),
              ),
            ),
          ),
        ],
      ),
    );
  }
}