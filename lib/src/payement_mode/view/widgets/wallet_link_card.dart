import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletLinkCard extends StatelessWidget {
  const WalletLinkCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.56, vertical: 7.78),
            child: Text(
              'Wallets',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.56,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Sidebaroption(), // Exact widget you provided
          ),
        ],
      ),
    );
  }
}

class Sidebaroption extends StatelessWidget {
  const Sidebaroption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 314,
          padding: const EdgeInsets.symmetric(
            horizontal: 15.56,
            vertical: 11.67,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFF313038),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            // Simplified to a single Row for clarity
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Icon and Name
              Row(
                children: [
                  Container(
                    width: 23.33,
                    height: 23.33,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.network(
                        "https://placehold.co/21x8",
                        width: 20.90,
                        height: 8.26,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11.67),
                  const Text(
                    'Paytm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.56,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // Right side: Clickable "Link Now"
              GestureDetector(
                onTap: () {
                  context.push('/walletLinkingPage');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11.67,
                    vertical: 3.89,
                  ),
                  decoration: BoxDecoration(
                    // You can add a background color here if needed
                    borderRadius: BorderRadius.circular(11.67),
                  ),
                  child: const Text(
                    'Link Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF16996B),
                      fontSize: 11.67,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
