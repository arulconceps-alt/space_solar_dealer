import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/widgets/default_top_navigation_bar.dart';
import 'widgets/payment_summary_card.dart';
import 'widgets/recommended_methods_card.dart';
import 'widgets/wallet_link_card.dart';
import 'widgets/other_payment_methods_card.dart';

class PaymentModePage extends StatelessWidget {
  const PaymentModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      appBar: DefaultTopNavigationBar(
        title: 'Payment Mode',
        onBackTap: () => Navigator.pop(context),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: ViewOffersButton()),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: Column(
            children: [
              const PaymentSummaryCard(),
              const SizedBox(height: 16),
              const RecommendedMethodsCard(),
              const SizedBox(height: 16),
              const WalletLinkCard(),
              const SizedBox(height: 16),
              const OtherPaymentMethodsCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewOffersButton extends StatelessWidget {
  const ViewOffersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint("View Offers Tapped"),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'View Offers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
