import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = (w / 440).clamp(0.85, 1.2);
    double s(double v) => v * scale;

    return Container(
      height: s(98),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F9FF),
        border: Border(top: BorderSide(color: Colors.white, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, "Dashboard",
              "assets/images/bottom_navigation/dashboard_icon.png", s),
          _buildNavItem(1, "Customer",
              "assets/images/bottom_navigation/customer_icon.png", s),
          _buildNavItem(2, "Tickets",
              "assets/images/bottom_navigation/tickets_icon.png", s),
          _buildNavItem(3, "Profile",
              "assets/images/bottom_navigation/profile_icon.png", s),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String label,
    String imagePath,
    double Function(double) s,
  ) {
    bool isSelected = currentIndex == index;

    Color activeColor = const Color(0xFF26A7DF);
    Color inactiveColor = const Color(0xFF707070);

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: s(30),
            height: s(30),
            color: isSelected ? activeColor : inactiveColor,
          ),
          SizedBox(height: s(5)),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: s(8),
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}