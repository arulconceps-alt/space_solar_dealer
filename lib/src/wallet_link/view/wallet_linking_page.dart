import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart'; // Ensure this path is correct

class WalletLinkingPage extends StatelessWidget {
  const WalletLinkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      body: Column(
        children: [
          _buildCustomStatusBar(),
          _buildCustomAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              // Added scroll for smaller screens
              child: Center(
                child: Container(
                  width: 336,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF24232A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLogoHeader(),
                      const SizedBox(height: 24),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFF3F5F4),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.network("https://placehold.co/43x17", width: 43),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Link Paytm wallet with',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        const Text(
          '9900887766',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // --- PROCEED BUTTON ---
        GestureDetector(
          onTap: () => context.pushNamed(RouteName.walletOtpSent),
          child: Container(
            width: double.infinity,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Proceed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // --- CANCEL BUTTON ---
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: double.infinity,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF313038),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomStatusBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('7:59 AM', style: TextStyle(color: Colors.white, fontSize: 12)),
          Icon(Icons.battery_full, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const Text(
            'Link Paytm Wallet',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
