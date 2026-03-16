import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
// import your ColorPalette

class BottomEditUsername extends StatefulWidget {
  final String currentName;
  const BottomEditUsername({Key? key, required this.currentName})
    : super(key: key);

  @override
  State<BottomEditUsername> createState() => _BottomEditUsernameState();
}

class _BottomEditUsernameState extends State<BottomEditUsername> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: ColorPalette.backgroundDark, // instead of 0xFF24232A
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title + Close Button
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ColorPalette.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Change Username",
                style: TextStyle(
                  color: ColorPalette.textPrimary,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),

          // Username Input Container
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.035,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x2627245D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Username",
                  style: TextStyle(
                    color: ColorPalette.textPrimary,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.14,
                  ),
                ),
                SizedBox(height: screenWidth * 0.025),
                Container(
                  height: screenWidth * 0.12,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: ColorPalette.backgroundDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: ColorPalette.textPrimary,
                      fontSize: screenWidth * 0.04,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter username",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenWidth * 0.04),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: screenWidth * 0.12,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primary, // solid color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                String newName = _controller.text.trim();
                if (newName.isNotEmpty) {
                  Navigator.pop(context, newName);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: ColorPalette.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
