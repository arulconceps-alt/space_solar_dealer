import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/myAccount/view/widget/bottom_change_avatar.dart';
import 'package:space_solar_dealer/src/myAccount/view/widget/bottom_edit_username.dart';

import 'package:go_router/go_router.dart';
import '../../app/color_palette.dart';
import '../../common/widgets/custom_success_snackbar.dart';
import '../../drawer_menu/view/drawer_menu.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _username = "JohnDoe";
  final String wallet_image = "assets/images/myAccount/wallet_image.png";
  late String person_image = "assets/images/myAccount/avatar_icons/a1.png";
  final String passbook_icon = "assets/images/myAccount/passbook_icon.png";
  final String kyc_verify_icon = "assets/images/myAccount/leadingIcon.png";
  final String customer_care_icon =
      "assets/images/myAccount/customer_care_icon.png";
  final String right_arrow_icon =
      "assets/images/myAccount/right_arrow_icon.png";
  final String logout_icon = "assets/images/myAccount/logout_Icon.png";
  @override
  void initState() {
    super.initState();
    _loadAccountData();
  }

  // 2. Create a function to handle the loading logic
  Future<void> _loadAccountData() async {
    // Simulate a network delay (replace with your actual API call)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        isLoading = false; // Hide loader after data is "loaded"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.background,
      drawer: const DrawerMenu(), // Uncomment if needed
      appBar: AppBar(
        backgroundColor: ColorPalette.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorPalette.textPrimary),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text(
          "My Account",
          style: TextStyle(color: ColorPalette.textPrimary, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _profileSection(),
                  const SizedBox(height: 16),
                  _walletSection(),
                  const SizedBox(height: 16),
                  _menuCard(passbook_icon, "Passbook", "/home"),
                  const SizedBox(height: 8),
                  _menuCard(kyc_verify_icon, "KYC Verification", "/kyc_verify"),
                  const SizedBox(height: 8),
                  _customerCare(),
                  const SizedBox(height: 8),
                  _logout(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFE6C35A)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _profileSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: ColorPalette.backgroundDark,
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFFC4C4C4),
                child: ClipOval(
                  child: Image.asset(
                    person_image,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                child: GestureDetector(
                  onTap: () async {
                    final selectedAvatar = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const BottomChangeAvatar(),
                    );

                    if (selectedAvatar != null) {
                      setState(() {
                        person_image = selectedAvatar;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF27245D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: ColorPalette.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorPalette.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _username,
                          style: TextStyle(
                            color: ColorPalette.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () async {
                          final newName = await showModalBottomSheet<String>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) =>
                                BottomEditUsername(currentName: _username),
                          );

                          if (newName != null && newName.isNotEmpty) {
                            setState(() {
                              _username = newName; // update UI
                            });

                            // Show snackbar here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                content: CustomSuccessSnackbar(
                                  message: "Username changed successfully",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: ColorPalette.primaryGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "+91 7802013615",
                  style: TextStyle(
                    color: ColorPalette.textSecondary,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: ColorPalette.backgroundDark,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/myAccount/wallet_image.png",
            width: 64,
            height: 64,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TOTAL WALLET BALANCE",
                  style: TextStyle(
                    color: ColorPalette.textSecondary,
                    fontSize: 14,
                    letterSpacing: 1.12,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "₹1239.30",
                  style: TextStyle(
                    color: ColorPalette.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _walletRow(
                  context,
                  "DEPOSIT BALANCE",
                  "₹123",
                  "Add Money",
                  true,
                  "/AddMoneyPage",
                ),
                const SizedBox(height: 20),
                _walletRow(
                  context,
                  "WINNINGS",
                  "₹123",
                  "Withdraw",
                  false,
                  "/withdrawPage",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletRow(
    BuildContext context,
    String label,
    String amount,
    String button,
    bool fill,
    String route,
  ) {
    return InkWell(
      onTap: () {
        context.push(route);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: ColorPalette.textTertiary,
                    fontSize: 12,
                    letterSpacing: 0.96,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    color: ColorPalette.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE BUTTON
          GestureDetector(
            onTap: () {
              // Case-sensitive check: match the 'button' text exactly
              if (button == "Withdraw") {
                context.pushNamed(RouteName.withdrawPage); // Use Named Route
              } else if (button == "Add Money") {
                context.pushNamed(RouteName.AddMoneyPage); // Use Named Route
              }
            },
            child: Container(
              width: 112,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: fill ? ColorPalette.primaryGradient : null,
                borderRadius: BorderRadius.circular(8),
                color: fill ? null : Colors.transparent,
                border: fill
                    ? null
                    : Border.all(color: ColorPalette.primary, width: 1.5),
              ),
              child: Text(
                button,
                style: TextStyle(
                  color: fill ? ColorPalette.textPrimary : ColorPalette.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(String iconPath, String title, String route) {
    return InkWell(
      onTap: () {
        context.push(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: ColorPalette.backgroundDark,
        child: Row(
          children: [
            Image.asset(iconPath, width: 22, height: 22),
            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: ColorPalette.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),

            Image.asset(right_arrow_icon, width: 16, height: 16),
          ],
        ),
      ),
    );
  }

  Widget _customerCare() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: ColorPalette.backgroundDark,
      child: Row(
        children: [
          Image.asset(customer_care_icon, width: 22, height: 22),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Customer Care",
              style: TextStyle(color: ColorPalette.textPrimary, fontSize: 14),
            ),
          ),
          _smallButton("Message"),
          const SizedBox(width: 8),
          _smallButton("Call Us"),
        ],
      ),
    );
  }

  Widget _smallButton(String text) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorPalette.background,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _logout() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: ColorPalette.backgroundDark,
      child: Row(
        children: [
          Image.asset(logout_icon, width: 22, height: 22),
          const SizedBox(width: 12),
          const Text(
            "Logout",
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
