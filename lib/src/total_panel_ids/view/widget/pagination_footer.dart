import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginationFooter extends StatelessWidget {
  final int totalItems;
  final int currentPage;
  final Function(int) onPageChanged;

  const PaginationFooter({
    super.key,
    required this.totalItems,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return SizedBox(
      width: s(266),
      height: s(30), // Increased slightly for better tap targets
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// TOTAL TEXT
          Text(
            "Total $totalItems",
            style: GoogleFonts.dmSans(
              fontSize: s(14),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9F9F9F),
            ),
          ),

          const Spacer(),

          /// PAGE NUMBERS
          _pageNumber(s, "1", currentPage == 1),
          SizedBox(width: 24,),
          _pageNumber(s, "2", currentPage == 2),
          SizedBox(width: 24,),
          _pageNumber(s, "3", currentPage == 3),

          SizedBox(width: s(24)),

          /// NAVIGATION BUTTONS
          _navButton(s, Icons.chevron_left, () {
            if (currentPage > 1) onPageChanged(currentPage - 1);
          }),

          SizedBox(width: s(8)),

          _navButton(s, Icons.chevron_right, () {
            // Optional: check for max items before changing page
            onPageChanged(currentPage + 1);
          }),
        ],
      ),
    );
  }

  /// HELPER: PAGE NUMBER TEXT
  Widget _pageNumber(double Function(double) s, String num, bool isActive) {
    return GestureDetector(
      onTap: () => onPageChanged(int.parse(num)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(6)),
        child: Text(
          num,
          style: GoogleFonts.lato(
            fontSize: s(14),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF26A7DF) : Colors.grey,
          ),
        ),
      ),
    );
  }

  /// HELPER: BLUE NAV BUTTON
  Widget _navButton(double Function(double) s, IconData icon, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: s(28),
        height: s(28),
        decoration: BoxDecoration(
          color: const Color(0xFF26A7DF), // Light blue from image
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: s(18),
        ),
      ),
    );
  }
}