import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class LogoutButton extends StatelessWidget {
  final double scale;

  const LogoutButton({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        borderRadius: BorderRadius.circular(s(10)),
        onTap: () {
          _showLogoutDialog(context, s);
        },
        child: Container(
          height: s(44),
           width: s(142),
          padding: EdgeInsets.symmetric(
            horizontal: s(26),
            vertical: s(8),
          ),
          decoration: BoxDecoration(
            color: ColorPalette.bottomtext,
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: ColorPalette.whitetext),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/profile/logout.png",
                width: s(24),
                height: s(24),
                 color: ColorPalette.whitetext,
              ),
              SizedBox(width: s(5)),
              Text(
                "Logout",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(
      BuildContext context,
      double Function(double) s,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(s(16)),
          ),
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
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
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                // Navigate login screen
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
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