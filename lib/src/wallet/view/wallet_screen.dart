import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../app/color_palette.dart';
import '../../drawer_menu/view/drawer_menu.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.background,
      drawer: const DrawerMenu(),
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
          "Wallet",
          style: TextStyle(color: ColorPalette.textPrimary, fontSize: 18),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _walletSection(),
              const SizedBox(height: 16),
              _menuCard(passbook_icon, "Passbook","/home"),
              const SizedBox(height: 8),
              _menuCard(kyc_verify_icon, "KYC Verification","/kyc_verify"),
            ],
          ),
        ),
      ),
    );
  }

  // WALLET
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

                _walletRow("DEPOSIT BALANCE", "\$123", "Add Money", true, "/AddMoneyPage"),

                const SizedBox(height: 20),

                _walletRow("WINNINGS", "₹123", "Withdraw", false, "/withdrawPage"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletRow(String label, String amount, String button, bool fill,String route) {
    return InkWell(
      onTap: () {
        context.push(route);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// LEFT SIDE (Label + Amount)
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
          Container(
            width: 112,
            // fixed width like Figma
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: fill ? ColorPalette.primaryGradient : null,
              borderRadius: BorderRadius.circular(8),
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
        ],
      ),
    );
  }

  // MENU
  Widget _menuCard(String iconPath, String title,String route) {
    return InkWell(
      onTap: () {
        context.push(route);
      },
      child: Container(
        width: double.infinity,
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
}
