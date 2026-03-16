import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletLinkCard extends StatelessWidget {
  const WalletLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Wallets',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildWalletItem(context, "Paytm", "https://placehold.co/21x8"),
        ],
      ),
    );
  }

  Widget _buildWalletItem(BuildContext context, String name, String logoUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Image.network(logoUrl, width: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () => context.push('/otp-verify'),
              child: const Text(
                'Link Now',
                style: TextStyle(
                  color: Color(0xFF16996B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
