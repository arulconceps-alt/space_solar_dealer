import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ✅ IMPORTANT
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

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
        border: Border(
          top: BorderSide(color: ColorPalette.whitetext, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, "Dashboard",
              "assets/images/bottom_navigation/dashboard_icon.svg", s),
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

    Color activeColor = ColorPalette.background;
    Color inactiveColor = const Color(0xFF000000).withOpacity(0.5);

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(
            imagePath,
            s(30),
            isSelected,
            activeColor,
            inactiveColor,
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

  Widget _buildIcon(
    String path,
    double size,
    bool isSelected,
    Color activeColor,
    Color inactiveColor,
  ) {
    final color = isSelected ? activeColor : inactiveColor;

    if (path.endsWith(".svg")) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return Image.asset(
        path,
        width: size,
        height: size,
        color: color,
      );
    }
  }
}