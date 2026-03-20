import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double scale; // Add this

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.scale, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90 * scale,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F9FF),
        border: Border(top: BorderSide(color: Colors.white, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, "Dashboard", "assets/images/bottom_navigation/dashboard_icon.png"),
          _buildNavItem(1, "Customer", "assets/images/bottom_navigation/customer_icon.png"),
          _buildNavItem(2, "Tickets", "assets/images/bottom_navigation/tickets_icon.png"),
          _buildNavItem(3, "Profile", "assets/images/bottom_navigation/profile_icon.png"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String imagePath) {
    bool isSelected = currentIndex == index; // Use currentIndex from the class
    Color activeColor = const Color(0xFF26A7DF);
    Color inactiveColor = const Color(0xFF707070);

    return InkWell(
      onTap: () => onTap(index), // Call the onTap function passed from Home
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 24 * scale,
            height: 24 * scale,
            color: isSelected ? activeColor : inactiveColor,
            colorBlendMode: BlendMode.srcIn,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 12 * scale,
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}