import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class WalletButton extends StatelessWidget {
  const WalletButton({super.key, this.balance = '₹ 200', this.onTap});

  final String balance;
  final VoidCallback? onTap;

  static const double _height = 32;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: _height,
          width: 110,
          // Fixed: Reduced padding to allow content to breathe
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: ShapeDecoration(
            // Fixed: Exact gradient and 8px radius
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.50),
              end: Alignment(0.00, 0.50),
              colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.white.withValues(alpha: 0.10),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Wallet Icon - Fixed: Smaller size for 32px height
              const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 14,
              ),

              // Balance Text - Fixed: Inter font and spacing
              Expanded(
                child: Text(
                  balance,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    letterSpacing: 0.14,
                  ),
                ),
              ),

              // Plus Button - Fixed: 20x20 container for perfect circle
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
