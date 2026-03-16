import 'package:flutter/material.dart';

class RecommendedMethodsCard extends StatelessWidget {
  const RecommendedMethodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.44,
      padding: const EdgeInsets.symmetric(vertical: 7.78),
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.56,
              vertical: 7.78,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommended',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.56,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcon(
                  'PhonePe',
                  Icons.account_balance_wallet,
                  Colors.purple,
                ),
                // Fixed: Changed Icons.google to Icons.account_balance
                _buildIcon('G-Pay', Icons.account_balance, Colors.blue),
                _buildIcon('Paytm', Icons.payment, Colors.lightBlue),
                _buildIcon('BHIM', Icons.qr_code_scanner, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String label, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 17.5,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(height: 11.67),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15.56),
        ),
      ],
    );
  }
}
