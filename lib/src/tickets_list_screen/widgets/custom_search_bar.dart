import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final double scale;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.scale,
    this.hintText = 'Search by Tickets ID, Panel ID or Customer',
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes it responsive
      height: 50 * scale,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Row(
        children: [
          // --- SEARCH ICON ---
          Image.asset(
            'assets/images/customer/search_icon.png', // Update with your actual path
            width: 24 * scale,
            height: 24 * scale,
            color: const Color(0xFF484848), // Optional: tints your icon
          ),

          SizedBox(width: 12 * scale),

          // --- INPUT FIELD ---
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                color: const Color(0xFF282828),
                fontSize: 16 * scale,
                fontFamily: 'Lato',
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xCC484848),
                  fontSize: 15 * scale, // Slightly smaller to fit long hints
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none, // Removes the default underline
                isDense: true, // Reduces vertical height to center text
              ),
            ),
          ),
        ],
      ),
    );
  }
}