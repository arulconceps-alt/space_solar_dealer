import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final double scale;
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBox({
    super.key,
    required this.scale,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/customer/search_icon.png', // Update with your actual path
            width: 24 * scale,
            height: 24 * scale,
            color: const Color(0xFF484848), // Optional: tints your icon
          ),

          SizedBox(width: 12 * scale),

          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 16 * scale,
                color: const Color(0xFF282828),
              ),
              decoration: InputDecoration(
                hintText: "Search by Customer",
                hintStyle: TextStyle(
                  fontSize: 16 * scale,
                  color: const Color(0xCC484848),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}