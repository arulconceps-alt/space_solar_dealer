import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/color_palette.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  // image paths
  final String person_image = "assets/images/menu_drawer/A.png";
  final String personIcon = "assets/images/menu_drawer/person_icon.png";
  final String referIcon = "assets/images/menu_drawer/refer_icon.png";
  final String premiumIcon = "assets/images/menu_drawer/premium_icon.png";
  final String walletIcon = "assets/images/menu_drawer/wallet_menu_icon.png";
  final String leaderBoardIcon = "assets/images/menu_drawer/leader_board_icon.png";
  final String gameHistoryIcon = "assets/images/menu_drawer/game_history_icon.png";
  final String supportChatIcon = "assets/images/menu_drawer/support_chat_icon.png";
  final String suggestionIcon = "assets/images/menu_drawer/suggestion_icon.png";
  final String termsIcon = "assets/images/menu_drawer/terms_icon.png";
  final String privacyIcon = "assets/images/menu_drawer/privacy_icon.png";
  final String responsibleIcon = "assets/images/menu_drawer/responsible_icon.png";
  final String logout_icon = "assets/images/menu_drawer/logout_Icon.png";

  /// Returns a responsive drawer width based on screen size
  double _drawerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1024) {
      // Large tablets / desktop: 320px fixed
      return 320;
    } else if (screenWidth >= 600) {
      // iPad / small tablets: 75% of screen, capped at 360px
      return (screenWidth * 0.75).clamp(280, 360);
    } else {
      // Phones: 85% of screen width
      return screenWidth * 0.85;
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerWidth = _drawerWidth(context);

    return SafeArea(
      child: Drawer(
        width: drawerWidth, // ← KEY FIX: explicit responsive width
        backgroundColor: ColorPalette.background,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          children: [
            /// HEADER
            _buildHeader(context),

            /// MENU LIST
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(context, personIcon, "My Account",
                      route: "/myAccount"),
                  _buildMenuItem(context, referIcon, "Refer & Earn"),
                  _buildMenuItem(
                    context,
                    premiumIcon,
                    "Premium Membership",
                    hasGlow: true,
                  ),
                  _buildMenuItem(context, walletIcon, "Wallet",
                      route: "/wallet"),
                  _buildMenuItem(context, leaderBoardIcon, "Leaderboard"),
                  _buildMenuItem(context, gameHistoryIcon, "Game History"),
                  _buildMenuItem(
                    context,
                    supportChatIcon,
                    "Support Chat",
                    route: "/chat",
                  ),
                  _buildMenuItem(context, suggestionIcon, "Suggestion Box",
                      route: "/suggestion"),
                  _buildMenuItem(
                      context, termsIcon, "Terms & Conditions"),
                  _buildMenuItem(context, privacyIcon, "Privacy"),
                  _buildMenuItem(
                      context, responsibleIcon, "Responsible Gaming"),
                ],
              ),
            ),

            /// FOOTER
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      color: const Color(0xFF252429),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Avatar
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFC4C4C4),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                person_image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// Username + Phone
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(
                    color: Color(0xFFFEFEFE),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "+91- 99988776655",
                  style: TextStyle(
                    color: Color(0xFFFEFEFE),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          /// Close button
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white70,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  /// MENU ITEM
  Widget _buildMenuItem(
      BuildContext context,
      String iconPath,
      String title, {
        bool hasGlow = false,
        String? route,
      }) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -2),
      leading: Container(
        decoration: hasGlow
            ? BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        )
            : null,
        child: Image.asset(
          iconPath,
          width: 22,
          height: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white38,
        size: 18,
      ),
      onTap: () {
        Navigator.pop(context);
        if (route != null) {
          context.go(route);
        }
      },
    );
  }

  /// FOOTER
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF252429),
        border: Border(
          top: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App version 2.32",
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  Text(
                    "App is upto Date",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text(
                  "Update App",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Image.asset(
                  logout_icon,
                  width: 22,
                  height: 22,
                ),
                const SizedBox(width: 12),
                const Text(
                  "Logout",
                  style: TextStyle(
                    color: Color(0xFFE71E25),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}