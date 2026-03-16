import 'package:flutter/material.dart';

class DefaultTopNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final List<Widget>? actions; // To support icons on the right
  final Color backgroundColor;
  final bool showBackButton;

  const DefaultTopNavigationBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.actions,
    this.backgroundColor = const Color(0xFF1C1B20),
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0, // Reduces gap between back button and title
      automaticallyImplyLeading: false, // We control the leading widget
      // --- Leading (Back Button) ---
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ), // Aligns with your 16px total padding
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onBackTap ?? () => Navigator.maybePop(context),
              ),
            )
          : null,

      // --- Title ---
      title: Padding(
        padding: EdgeInsets.only(left: showBackButton ? 0 : 16),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.18,
          ),
        ),
      ),

      // --- Actions (Right side icons) ---
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: 8), // Right side padding
            ]
          : null,
    );
  }
}
